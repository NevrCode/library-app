import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:library_app/db-handler/sqlite_handler.dart';
import 'package:library_app/item-generators/admin_member_card.dart';
import 'package:sqflite/sqflite.dart';
import 'book_card.dart';
import 'book_of_the_week_card.dart';
import 'package:library_app/constants/membertype.dart';

class DatabaseWidgetGenerator {
  static Future<bool> isMemberUnique(String name) async {
    Database db = await SqliteHandler().myOpenDatabase();
    final nameList =
        await db.query("user_account", where: "username=?", whereArgs: [name]);
    return nameList[0]["username"] == null;
  }

  static Future<String> _generateReadMeId() async {
    Database db = await SqliteHandler().myOpenDatabase();
    final memberKeyTable =
        await db.rawQuery("SELECT MAX(ROWID) AS id FROM member");
    int rowid = memberKeyTable[0]["id"] as int;
    int rowidOffset = rowid + 3100;
    String memberKey = "Readme-${rowidOffset.toString().padLeft(4, '0')}";
    return memberKey;
  }

  static Future<Map> login(String username, String password) async {
    Database db = await SqliteHandler().myOpenDatabase();
    final dataList = await db.rawQuery(
        "SELECT username,password,id_member,id_admin FROM user_account WHERE username=? AND password=?",
        [username, password]);
    if (dataList.isEmpty) {
      return {
        "memberType": MemberType.unregistered,
      };
    } else if (dataList[0]["id_admin"] == null) {
      final String memberKey = dataList[0]["id_member"] as String;
      final memberData = await db.rawQuery(
          "SELECT * FROM member LEFT JOIN tingkat ON member.id_tingkat = tingkat.id_tingkat WHERE member.id_member = ?",
          [memberKey]);
      return {
        // the first only
        "memberType": MemberType.user,
        "id": memberData[0]["id_member"] as String,
        "name": memberData[0]["nama_member"] as String,
        "tingkat": memberData[0]["nama_tingkat"] as String,
        "sisa_pinjam": memberData[0]["sisa_kuota"] as int,
        "tgl_balik": memberData[0]["tgl_balik"] as String?,
      };
    } else {
      return {
        "memberType": MemberType.admin,
      };
    }
  }

  static void register(
      {String name = "", String? email, String password = ""}) async {
    Database db = await SqliteHandler().myOpenDatabase();
    String readmeId = await DatabaseWidgetGenerator._generateReadMeId();
    await db.insert("member", {
      "id_member": readmeId,
      "nama_member": name,
      "id_tingkat": 0,
      "sisa_kuota": 3,
      "buku_yang_sudah_dipinjam": 0,
    });
    await db.insert("user_account",
        {"username": name, "password": password, "id_member": readmeId});
  }

  static void changeMemberInfo(
      String idMember, String username, String password) async {
    Database db = await SqliteHandler().myOpenDatabase();
    if (username.isEmpty && password.isEmpty) {
      // dont do anything
      return;
    }
    if (username.isEmpty) {
      await db.update("user_account", {"password": password},
          where: 'id_member = ?', whereArgs: [idMember]);
      return;
    }
    if (password.isEmpty) {
      await db.update("user_account", {"username": username},
          where: 'id_member = ?', whereArgs: [idMember]);
      await db.update(
          "member",
          {
            "nama_member": username,
          },
          where: "id_member = ?",
          whereArgs: [idMember]);
      return;
    }
    await db.update(
        "user_account", {"username": username, "password": password},
        where: 'id_member = ?', whereArgs: [idMember]);
    await db.update(
        "member",
        {
          "nama_member": username,
        },
        where: "id_member = ?",
        whereArgs: [idMember]);
    return;
  }

  // tinggal di implement
  static Future<List<AdminMemberCard>> _generateAdminMemberCardsFromDB() async {
    Database db = await SqliteHandler().myOpenDatabase();
    final dataList = await db.query("member");
    return List.generate(
        dataList.length,
        (index) => AdminMemberCard(
            nama: dataList[index]["username"] as String,
            pass: dataList[index]["password"] as String));
  }

  static Future<List<BookOfTheWeekCard>> _generateBookOfTheWeekCardFromDB(
      String parent,
      {String? idMember}) async {
    Database db = await SqliteHandler().myOpenDatabase();
    final dataList = await db.rawQuery('SELECT * FROM buku');

    return List.generate(
      dataList.length,
      (index) => BookOfTheWeekCard(
        parent: parent,
        judul: dataList[index]["judul"] as String,
        sinopsis: dataList[index]["sinopsis"] as String,
        imagePath: dataList[index]["foto_sampul"] as String?,
        idBuku: dataList[index]["id_buku"] as int,
        idMember: idMember,
      ),
    );
  }

  static Future<List<BookCard>> _generateBookCardFromDB(String parent,
      {String? genre, String? idMember}) async {
    Database db = await SqliteHandler().myOpenDatabase();
    List<Map> dataList = [{}];
    if (genre != null) {
      String sql = """SELECT * FROM buku 
LEFT JOIN genre_buku ON buku.id_buku = genre_buku.id_buku
LEFT JOIN genre ON genre_buku.id_genre = genre.id_genre
WHERE genre.nama_genre = ?;""";
      dataList = await db.rawQuery(sql, [genre]);
    } else {
      dataList = await db.rawQuery('SELECT * FROM buku');
    }

    return List.generate(
      dataList.length,
      (index) => BookCard(
        parent: parent,
        judul: dataList[index]["judul"] as String,
        sinopsis: dataList[index]["sinopsis"] as String,
        imagePath: dataList[index]["foto_sampul"] as String?,
        idBuku: dataList[index]["id_buku"] as int,
        idMember: idMember,
      ),
    );
  }

  static FutureBuilder<List<AdminMemberCard>> makeAdminMemberCards() {
    return FutureBuilder(
        future: DatabaseWidgetGenerator._generateAdminMemberCardsFromDB(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<AdminMemberCard> adminMemberCard = snapshot.data ?? [];
            if (adminMemberCard.isEmpty) {
              return const AdminMemberCard(
                  nama: "placeholder", pass: "place_holder");
            } else {
              // sepuh kepin tolong dong kalo salah wkkwkw
              return SizedBox(
                height: 260,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: false,
                  itemCount: adminMemberCard.length,
                  itemBuilder: (context, index) {
                    return adminMemberCard[index];
                  },
                ),
              );
            }
          }
        }));
  }

  static FutureBuilder<List<BookOfTheWeekCard>> makeBookOfTheWeekCards(
      String parent,
      {String? idMember}) {
    return FutureBuilder(
      future: DatabaseWidgetGenerator._generateBookOfTheWeekCardFromDB(parent,
          idMember: idMember),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<BookOfTheWeekCard> bookOfTheWeekCard = snapshot.data ?? [];
          if (bookOfTheWeekCard.isEmpty) {
            return BookOfTheWeekCard(
              parent: parent,
              judul: "Judul Buku",
              sinopsis: "sinopsis",
            );
          } else {
            return SizedBox(
              height: 260,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: false,
                itemCount: bookOfTheWeekCard.length,
                itemBuilder: (context, index) {
                  return bookOfTheWeekCard[index];
                },
              ),
            );
          }
        }
      },
    );
  }

  static FutureBuilder<List<BookCard>> makeBookCards(String parent,
      {String? genre, String? idMember}) {
    return FutureBuilder(
      future: DatabaseWidgetGenerator._generateBookCardFromDB(parent,
          genre: genre, idMember: idMember),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<BookCard> bookCard = snapshot.data ?? [];
          if (bookCard.isEmpty) {
            return BookCard(
              parent: "home",
              judul: "Judul Buku",
              sinopsis: "sinopsis",
              idBuku: -1,
              idMember: idMember,
            );
          } else {
            return GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.63,
              ),
              itemCount: bookCard.length,
              itemBuilder: (context, index) {
                return bookCard[
                    index]; // Or any other widget you want to display
              },
            );
          }
        }
      },
    );
  }

  static void pinjamBuku(String? idMember, int? idBuku) async {
    Database db = await SqliteHandler().myOpenDatabase();
    DateFormat sqlDateFormat = DateFormat("yyyy-MM-dd");
    DateTime today = DateTime.now();
    String todayDateString = sqlDateFormat.format(today);

    if (idMember == null || idBuku == null) {
      // early exit to  prevent some accidental queries
      return;
    }
    // sisa pinjam harus dikurangi
    await db.rawQuery(
        "UPDATE member SET sisa_kuota = sisa_kuota - 1 WHERE id_member = ?",
        [idMember]);
    // insert ke tabel peminjaman dengan subquery
    final tabelLamaPinjam =
        await db.rawQuery("""SELECT lama_pinjam FROM tingkat WHERE id_tingkat = 
(SELECT id_tingkat FROM member WHERE id_member = ?);""", [idMember]);
    final int lamaPinjam = tabelLamaPinjam[0]["lama_pinjam"] as int;
    DateTime deadlineDateTime = today.add(Duration(days: lamaPinjam));
    String deadline = sqlDateFormat.format(deadlineDateTime);

    await db.insert("peminjaman", {
      "id_member": idMember,
      "tgl_peminjaman": todayDateString,
      "tgl_kadarluasa": deadline
    });
    // insert detail peminjaman
    final idPeminjamanTerakhirTable =
        await db.rawQuery("SELECT MAX(id_peminjam) AS id FROM peminjaman");
    int idPinjam = idPeminjamanTerakhirTable[0]["id"] as int;
    await db.insert(
        "detail_pinjaman", {"id_peminjaman": idPinjam, "id_buku": idBuku});
  }

  static void kembalikanBuku(
      String idPeminjaman, String idBuku, String idMember) async {
    Database db = await SqliteHandler().myOpenDatabase();
    // delete peminjaman
    await db.delete("peminjaman",
        where: "id_peminjam = ?", whereArgs: [idPeminjaman]);
    // delete detail peminjaman tidak perlu karena CASCADE
    // increment ulang buku
    await db.rawQuery(
        "UPDATE member SET sisa_kuota = sisa_kuota + 1 WHERE id_member = ?",
        [idMember]);
  }

  // opsional?
  static void kembalikanSemuaBuku(String idMember) async {
    Database db = await SqliteHandler().myOpenDatabase();
    int deletedAmnount = await db
        .delete("peminjaman", where: "id_member = ?", whereArgs: [idMember]);
    await db.rawQuery(
        "UPDATE member SET sisa_kuota = sisa_kuota + ? WHERE id_member = ?",
        [deletedAmnount, idMember]);
  }
}

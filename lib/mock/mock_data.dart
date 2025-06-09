import 'package:wonder/src/data/facility_item.dart';
import 'package:wonder/src/data/list_value_item.dart';
import 'package:wonder/src/data/user_item.dart';

class MockData {
  static final facilities = [
    {
      "id": "1.0",
      "itemType": "facility",
      "number": 1.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "type": "facilityType_villa"
    },
    {
      "id": "2.0",
      "itemType": "facility",
      "number": 2.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 1.0,
      "status": "facilityStatus_operational",
      "owner": "henning_helmich",
      "type": "facilityType_villa"
    },
    {
      "id": "3.0",
      "itemType": "facility",
      "number": 3.0,
      "subtype": "facilitySubtype_a",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "maria_lovina",
      "type": "facilityType_villa"
    },
    {
      "id": "4.0",
      "itemType": "facility",
      "number": 4.0,
      "subtype": "facilitySubtype_a",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "jane_dwyer",
      "type": "facilityType_villa"
    },
    {
      "id": "5.0",
      "itemType": "facility",
      "number": 5.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "shmuel_constantini",
      "type": "facilityType_villa"
    },
    {
      "id": "6.0",
      "itemType": "facility",
      "number": 6.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 3.0,
      "status": "facilityStatus_notStarted",
      "owner": "ofer_rotem",
      "type": "facilityType_villa"
    },
    {
      "id": "7.0",
      "itemType": "facility",
      "number": 7.0,
      "subtype": "facilitySubtype_a",
      "roomCount": 2.0,
      "status": "facilityStatus_notStarted",
      "owner": "evelin_haimovich",
      "type": "facilityType_villa"
    },
    {
      "id": "8.0",
      "itemType": "facility",
      "number": 8.0,
      "subtype": "facilitySubtype_a",
      "roomCount": 2.0,
      "status": "facilityStatus_notStarted",
      "owner": "christian_buettne",
      "type": "facilityType_villa"
    },
    {
      "id": "9.0",
      "itemType": "facility",
      "number": 9.0,
      "subtype": "facilitySubtype_a",
      "roomCount": 3.0,
      "status": "facilityStatus_notStarted",
      "owner": "lee_birman",
      "type": "facilityType_villa"
    },
    {
      "id": "10.0",
      "itemType": "facility",
      "number": 10.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 2.0,
      "status": "facilityStatus_notStarted",
      "owner": "michal_rotem",
      "type": "facilityType_villa"
    },
    {
      "id": "11.0",
      "itemType": "facility",
      "number": 11.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 3.0,
      "status": "facilityStatus_notStarted",
      "owner": "eyal_zaichic",
      "type": "facilityType_villa"
    },
    {
      "id": "12.0",
      "itemType": "facility",
      "number": 12.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 2.0,
      "status": "facilityStatus_notStarted",
      "owner": "alexander_kuchar",
      "type": "facilityType_villa"
    },
    {
      "id": "13.0",
      "itemType": "facility",
      "number": 13.0,
      "subtype": "facilitySubtype_a",
      "roomCount": 3.0,
      "status": "facilityStatus_notStarted",
      "owner": "david_ben ari",
      "type": "facilityType_villa"
    },
    {
      "id": "14.0",
      "itemType": "facility",
      "number": 14.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 2.0,
      "status": "facilityStatus_notStarted",
      "owner": "baha_shoucair",
      "type": "facilityType_villa"
    },
    {
      "id": "15.0",
      "itemType": "facility",
      "number": 15.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 2.0,
      "status": "facilityStatus_notStarted",
      "owner": "alex_zak",
      "type": "facilityType_villa"
    },
    {
      "id": "16.0",
      "itemType": "facility",
      "number": 16.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 2.0,
      "status": "facilityStatus_notStarted",
      "owner": "gad_baum",
      "type": "facilityType_villa"
    },
    {
      "id": "47.0",
      "itemType": "facility",
      "number": 47.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "noga_polansky",
      "type": "facilityType_villa"
    },
    {
      "id": "48.0",
      "itemType": "facility",
      "number": 48.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "roy_ben abraham",
      "type": "facilityType_villa"
    },
    {
      "id": "49.0",
      "itemType": "facility",
      "number": 49.0,
      "subtype": "facilitySubtype_a",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "esther_ben ari",
      "type": "facilityType_villa"
    },
    {
      "id": "51.0",
      "itemType": "facility",
      "number": 51.0,
      "subtype": "facilitySubtype_a",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "shachar_cohen",
      "type": "facilityType_villa"
    },
    {
      "id": "52.0",
      "itemType": "facility",
      "number": 52.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "type": "facilityType_villa"
    },
    {
      "id": "53.0",
      "itemType": "facility",
      "number": 53.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 3.0,
      "status": "facilityStatus_notStarted",
      "owner": "yaron_weber",
      "type": "facilityType_villa"
    },
    {
      "id": "54.0",
      "itemType": "facility",
      "number": 54.0,
      "subtype": "facilitySubtype_a",
      "roomCount": 3.0,
      "status": "facilityStatus_notStarted",
      "owner": "yut_doe",
      "type": "facilityType_villa"
    },
    {
      "id": "55.0",
      "itemType": "facility",
      "number": 55.0,
      "subtype": "facilitySubtype_a",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "patrizia_chiozza",
      "type": "facilityType_villa"
    },
    {
      "id": "56.0",
      "itemType": "facility",
      "number": 56.0,
      "subtype": "facilitySubtype_a",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "aly_hazlewood",
      "type": "facilityType_villa"
    },
    {
      "id": "57.0",
      "itemType": "facility",
      "number": 57.0,
      "subtype": "facilitySubtype_a",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "lilac_lopez",
      "type": "facilityType_villa"
    },
    {
      "id": "64.0",
      "itemType": "facility",
      "number": 64.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "igal_daiboch",
      "type": "facilityType_villa"
    },
    {
      "id": "65.0",
      "itemType": "facility",
      "number": 65.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "guy_ben ami",
      "type": "facilityType_villa"
    },
    {
      "id": "66.0",
      "itemType": "facility",
      "number": 66.0,
      "subtype": "facilitySubtype_a",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "boaz_birman",
      "type": "facilityType_villa"
    },
    {
      "id": "67.0",
      "itemType": "facility",
      "number": 67.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "binyamin_markus",
      "type": "facilityType_villa"
    },
    {
      "id": "69.0",
      "itemType": "facility",
      "number": 69.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "trillium_seafyre",
      "type": "facilityType_villa"
    },
    {
      "id": "70.0",
      "itemType": "facility",
      "number": 70.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "michael_rosen",
      "type": "facilityType_villa"
    },
    {
      "id": "71.0",
      "itemType": "facility",
      "number": 71.0,
      "subtype": "facilitySubtype_a",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "bishara_haroni",
      "type": "facilityType_villa"
    },
    {
      "id": "72.0",
      "itemType": "facility",
      "number": 72.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "yuval_birman",
      "type": "facilityType_villa"
    },
    {
      "id": "73.0",
      "itemType": "facility",
      "number": 73.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "luisa_nebel",
      "type": "facilityType_villa"
    },
    {
      "id": "74.0",
      "itemType": "facility",
      "number": 74.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "shai_ben saadon",
      "type": "facilityType_villa"
    },
    {
      "id": "75.0",
      "itemType": "facility",
      "number": 75.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "yonathan_covary",
      "type": "facilityType_villa"
    },
    {
      "id": "76.0",
      "itemType": "facility",
      "number": 76.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "guy_regev",
      "type": "facilityType_villa"
    },
    {
      "id": "77.0",
      "itemType": "facility",
      "number": 77.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 3.0,
      "status": "facilityStatus_notStarted",
      "owner": "erez_zaichic",
      "type": "facilityType_villa"
    },
    {
      "id": "87.0",
      "itemType": "facility",
      "number": 87.0,
      "subtype": "facilitySubtype_a",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "ido_keinan",
      "type": "facilityType_villa"
    },
    {
      "id": "88.0",
      "itemType": "facility",
      "number": 88.0,
      "subtype": "facilitySubtype_a",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "arnauld_boulard",
      "type": "facilityType_villa"
    },
    {
      "id": "89.0",
      "itemType": "facility",
      "number": 89.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "asaf_yigal",
      "type": "facilityType_villa"
    },
    {
      "id": "90.0",
      "itemType": "facility",
      "number": 90.0,
      "subtype": "facilitySubtype_b",
      "roomCount": 1.0,
      "status": "facilityStatus_notStarted",
      "owner": "tzvi_kaplan",
      "type": "facilityType_villa"
    },
    {
      "id": "93.0",
      "itemType": "facility",
      "number": 93.0,
      "subtype": "facilitySubtype_a",
      "roomCount": 5.0,
      "status": "facilityStatus_planning",
      "owner": "ziv_shalev",
      "type": "facilityType_villa"
    }
  ].map(FacilityItem.fromFields).toList();
  static final users = [
    {
      "id": "no_pic",
      "itemType": "user",
      "email": "no.pic@gmail.com",
      "lastName": "pic",
      "firstName": "no",
    },
    {
      "id": "verylongfirstname_verylonglastname",
      "itemType": "user",
      "email": "no.pic@gmail.com",
      "lastName": "verylonglastname",
      "firstName": "verylongfirstname",
    },
    {
      "id": "igal_daiboch",
      "itemType": "user",
      "middleName": "Shai",
      "email": "igal.daiboch@gmail.com",
      "lastName": "Daiboch",
      "firstName": "Igal",
      "address": {
        "subdivisions": [
          {"code": "จ.สุราษฎร์ธานี", "name": "สุราษฎร์ธานี", "type": "ADMINISTRATIVE_AREA_LEVEL_1"},
          {
            "code": "อำเภอเกาะพะงัน",
            "name": "อำเภอเกาะพะงัน",
            "type": "ADMINISTRATIVE_AREA_LEVEL_2"
          },
          {"code": "ตำบลเกาะพะงัน", "name": "ตำบลเกาะพะงัน", "type": "ADMINISTRATIVE_AREA_LEVEL_3"},
          {"code": "TH", "name": "Thailand", "type": "COUNTRY"}
        ],
        "city": "ตำบลเกาะพะงัน",
        "location": {"latitude": 9.7441002, "longitude": 100.0037627},
        "countryFullname": "Thailand",
        "streetAddress": {
          "number": "",
          "name": "",
          "apt": "",
          "formattedAddressLine": "Wonderland Healing Center"
        },
        "formatted":
            "Wonderland Healing Center, Ko Pha-ngan, Ko Pha-ngan District, Surat Thani, Thailand",
        "country": "TH",
        "postalCode": "84280",
        "subdivision": "84"
      },
      "phone": "972529246310"
    },
    {
      "id": "alex_zak",
      "itemType": "user",
      "email": "a@alexzak.me",
      "lastName": "Zak",
      "firstName": "Alex"
    },
    {
      "id": "alexander_kuchar",
      "itemType": "user",
      "email": "tesnom333@gmail.com",
      "lastName": "Kuchar",
      "firstName": "Alexander"
    },
    {
      "id": "aly_hazlewood",
      "itemType": "user",
      "email": "Aly.hazlewood@gmail.com",
      "lastName": "hazlewood",
      "firstName": "Aly"
    },
    {
      "id": "arnauld_boulard",
      "itemType": "user",
      "email": "aboulard@mac.com",
      "lastName": "Boulard",
      "firstName": "Arnauld"
    },
    {
      "id": "asaf_yigal",
      "itemType": "user",
      "email": "Asaf.yigal@gmail.com",
      "lastName": "Yigal",
      "firstName": "Asaf"
    },
    {
      "id": "baha_shoucair",
      "itemType": "user",
      "middleName": "Kefi Ep",
      "email": "wshoucair@gmail.com",
      "lastName": "Shoucair",
      "firstName": "Baha"
    },
    {
      "id": "binyamin_markus",
      "itemType": "user",
      "email": "benmar71@gmail.com",
      "lastName": "Markus",
      "firstName": "Binyamin"
    },
    {
      "id": "bishara_haroni",
      "itemType": "user",
      "email": "Bashbash1111@gmail.com",
      "lastName": "Haroni",
      "firstName": "Bishara"
    },
    {
      "id": "boaz_birman",
      "itemType": "user",
      "email": "boaz_birman@gmail.com",
      "lastName": "Birman",
      "firstName": "Boaz",
      "address": {
        "subdivisions": [
          {"code": "จ.สุราษฎร์ธานี", "name": "สุราษฎร์ธานี", "type": "ADMINISTRATIVE_AREA_LEVEL_1"},
          {
            "code": "อำเภอเกาะพะงัน",
            "name": "อำเภอเกาะพะงัน",
            "type": "ADMINISTRATIVE_AREA_LEVEL_2"
          },
          {"code": "ตำบลเกาะพะงัน", "name": "ตำบลเกาะพะงัน", "type": "ADMINISTRATIVE_AREA_LEVEL_3"},
          {"code": "TH", "name": "Thailand", "type": "COUNTRY"}
        ],
        "city": "ตำบลเกาะพะงัน",
        "location": {"latitude": 9.7441002, "longitude": 100.0037627},
        "countryFullname": "Thailand",
        "streetAddress": {
          "number": "",
          "name": "",
          "apt": "",
          "formattedAddressLine": "Wonderland Healing Center"
        },
        "formatted":
            "Wonderland Healing Center, Ko Pha-ngan, Ko Pha-ngan District, Surat Thani, Thailand",
        "country": "TH",
        "postalCode": "84280",
        "subdivision": "84"
      },
      "picture": "boaz_birman.jpg",
      "phone": "66651219799"
    },
    {
      "id": "christian_buettne",
      "itemType": "user",
      "email": "cbuettner@live.com",
      "lastName": "Buettne",
      "firstName": "Christian"
    },
    {
      "id": "dana_shalev",
      "itemType": "user",
      "email": "danashalev100@gmail.com",
      "lastName": "Shalev",
      "firstName": "Dana",
      "address": {
        "subdivisions": [
          {
            "code": "Center District",
            "name": "Center District",
            "type": "ADMINISTRATIVE_AREA_LEVEL_1"
          },
          {"code": "Petach Tikva", "name": "Petach Tikva", "type": "ADMINISTRATIVE_AREA_LEVEL_2"},
          {
            "code": "Kokhav Ya'ir Tzur Yigal",
            "name": "Kokhav Ya'ir Tzur Yigal",
            "type": "ADMINISTRATIVE_AREA_LEVEL_3"
          },
          {"code": "IL", "name": "Israel", "type": "COUNTRY"}
        ],
        "city": "Kokhav Ya'ir Tzur Yigal",
        "location": {"latitude": 32.2318702, "longitude": 35.00897},
        "countryFullname": "Israel",
        "streetAddress": {
          "number": "34",
          "name": "Dan Street",
          "apt": "",
          "formattedAddressLine": "Dan St 34"
        },
        "formatted": "Dan Street 34, Kokhav Ya'ir Tzur Yigal, Israel",
        "country": "IL"
      },
      "picture": "dana_shalev.jpg",
      "phone": "972548145556"
    },
    {
      "id": "david_ben ari",
      "itemType": "user",
      "email": "eliyaba@gmail.com",
      "lastName": "Ben Ari",
      "firstName": "David"
    },
    {
      "id": "erez_zaichic",
      "itemType": "user",
      "email": "Erez@tamarail.co.il",
      "lastName": "Zaichic",
      "firstName": "Erez"
    },
    {
      "id": "esther_ben ari",
      "itemType": "user",
      "email": "egbenari@gmail.com",
      "lastName": "Ben Ari",
      "firstName": "Esther"
    },
    {
      "id": "evelin_haimovich",
      "itemType": "user",
      "email": "Tohar13@hotmail.com",
      "lastName": "Haimovich",
      "firstName": "Evelin"
    },
    {
      "id": "eyal_zaichic",
      "itemType": "user",
      "email": "anatnevo20@gmail.com",
      "lastName": "Zaichic",
      "firstName": "Eyal"
    },
    {
      "id": "gad_baum",
      "itemType": "user",
      "email": "gadbaum@gmail.com",
      "lastName": "Baum",
      "firstName": "Gad"
    },
    {
      "id": "guy_ben ami",
      "itemType": "user",
      "email": "guybena@gmail.com",
      "lastName": "Ben Ami",
      "firstName": "Guy"
    },
    {
      "id": "guy_regev",
      "itemType": "user",
      "email": "guyreg3@gmail.com",
      "lastName": "Regev",
      "firstName": "Guy"
    },
    {
      "id": "henning_helmich",
      "itemType": "user",
      "email": "Henning.Helmich@gmx.net",
      "lastName": "Helmich",
      "firstName": "Henning"
    },
    {
      "id": "ido_keinan",
      "itemType": "user",
      "email": "Idochalten@gmail.com",
      "lastName": "Keinan",
      "firstName": "Ido"
    },
    {
      "id": "jane_dwyer",
      "itemType": "user",
      "middleName": "Aniela",
      "email": "Pbyrne7@bigpond.com",
      "lastName": "Dwyer",
      "firstName": "Jane"
    },
    {
      "id": "lee_birman",
      "itemType": "user",
      "email": "_tmpleebirman@gmail.com",
      "lastName": "Birman",
      "firstName": "Lee",
      "nickname": "Yellow"
    },
    {
      "id": "lilac_lopez",
      "itemType": "user",
      "email": "lilaclopezco@gmail.com",
      "lastName": "Lopez",
      "firstName": "Lilac"
    },
    {
      "id": "luisa_nebel",
      "itemType": "user",
      "middleName": "Barbara",
      "email": "luisa.nebel@me.com",
      "lastName": "Nebel",
      "firstName": "Luisa"
    },
    {
      "id": "maria_lovina",
      "itemType": "user",
      "middleName": "Rosario Ines P.",
      "email": "macky.lovina@gmail.com",
      "lastName": "Lovina",
      "firstName": "Maria"
    },
    {
      "id": "michael_patzer",
      "itemType": "user",
      "middleName": "Alfred",
      "email": "nils@4fr.de",
      "lastName": "Patzer",
      "firstName": "Michael"
    },
    {
      "id": "michael_rosen",
      "itemType": "user",
      "email": "michael0390@gmail.com",
      "lastName": "Rosen",
      "firstName": "Michael"
    },
    {
      "id": "michal_rotem",
      "itemType": "user",
      "email": "michalrote@gmail.com",
      "lastName": "Rotem",
      "firstName": "Michal"
    },
    {
      "id": "nava_sanders",
      "itemType": "user",
      "email": "navanavax@gmail.com",
      "lastName": "Sanders",
      "firstName": "Nava"
    },
    {
      "id": "noga_polansky",
      "itemType": "user",
      "email": "noga.polansky@gmail.com",
      "lastName": "Polansky",
      "firstName": "Noga"
    },
    {
      "id": "ofer_rotem",
      "itemType": "user",
      "email": "oferrotem@gmail.com",
      "lastName": "Rotem",
      "firstName": "Ofer"
    },
    {
      "id": "patrizia_chiozza",
      "itemType": "user",
      "email": "patpita999@gmail.com",
      "lastName": "Chiozza",
      "firstName": "Patrizia"
    },
    {
      "id": "roy_ben abraham",
      "itemType": "user",
      "email": "roy.ben.abraham@gmail.com",
      "lastName": "Ben Abraham",
      "firstName": "Roy"
    },
    {
      "id": "shachar_cohen",
      "itemType": "user",
      "email": "Sha900@gmail.com",
      "lastName": "Cohen",
      "firstName": "Shachar"
    },
    {
      "id": "shai_ben saadon",
      "itemType": "user",
      "email": "SHAI@SHABASTV.COM",
      "lastName": "Ben Saadon",
      "firstName": "Shai"
    },
    {
      "id": "shmuel_constantini",
      "itemType": "user",
      "middleName": "Uli",
      "email": "uli@eau.co.il",
      "lastName": "Constantini",
      "firstName": "Shmuel"
    },
    {
      "id": "trillium_seafyre",
      "itemType": "user",
      "email": "trillium765@gmail.com",
      "lastName": "Seafyre",
      "firstName": "Trillium"
    },
    {
      "id": "tzvi_kaplan",
      "itemType": "user",
      "email": "Kaplan.tzvika@gmail.com",
      "lastName": "Kaplan",
      "firstName": "Tzvi"
    },
    {
      "id": "yaron_weber",
      "itemType": "user",
      "email": "yaronweber@gmail.com",
      "lastName": "Weber",
      "firstName": "Yaron",
      "address": {
        "subdivisions": [
          {"code": "จ.สุราษฎร์ธานี", "name": "สุราษฎร์ธานี", "type": "ADMINISTRATIVE_AREA_LEVEL_1"},
          {
            "code": "อำเภอเกาะพะงัน",
            "name": "อำเภอเกาะพะงัน",
            "type": "ADMINISTRATIVE_AREA_LEVEL_2"
          },
          {"code": "ตำบลเกาะพะงัน", "name": "ตำบลเกาะพะงัน", "type": "ADMINISTRATIVE_AREA_LEVEL_3"},
          {"code": "TH", "name": "Thailand", "type": "COUNTRY"}
        ],
        "city": "ตำบลเกาะพะงัน",
        "location": {"latitude": 9.7441002, "longitude": 100.0037627},
        "countryFullname": "Thailand",
        "streetAddress": {
          "number": "",
          "name": "",
          "apt": "",
          "formattedAddressLine": "Wonderland Healing Center"
        },
        "formatted":
            "Wonderland Healing Center, Ko Pha-ngan, Ko Pha-ngan District, Surat Thani, Thailand",
        "country": "TH",
        "postalCode": "84280",
        "subdivision": "84"
      },
      "picture": "yaron_weber.jpg",
      "phone": "66651219699",
      "nickname": "John"
    },
    {
      "id": "yonathan_covary",
      "itemType": "user",
      "email": "ykoevary@gmail.com",
      "lastName": "Covary",
      "firstName": "Yonathan"
    },
    {
      "id": "yut_doe",
      "itemType": "user",
      "email": "yutdoe@gmail.com",
      "lastName": "Doe",
      "firstName": "Yut"
    },
    {
      "id": "yuval_birman",
      "itemType": "user",
      "email": "flokichokdee@gmail.com",
      "lastName": "Birman",
      "firstName": "Yuval",
      "address": {
        "subdivisions": [
          {"code": "จ.สุราษฎร์ธานี", "name": "สุราษฎร์ธานี", "type": "ADMINISTRATIVE_AREA_LEVEL_1"},
          {
            "code": "อำเภอเกาะพะงัน",
            "name": "อำเภอเกาะพะงัน",
            "type": "ADMINISTRATIVE_AREA_LEVEL_2"
          },
          {"code": "ตำบลเกาะพะงัน", "name": "ตำบลเกาะพะงัน", "type": "ADMINISTRATIVE_AREA_LEVEL_3"},
          {"code": "TH", "name": "Thailand", "type": "COUNTRY"}
        ],
        "city": "ตำบลเกาะพะงัน",
        "location": {"latitude": 9.7441002, "longitude": 100.0037627},
        "countryFullname": "Thailand",
        "streetAddress": {
          "number": "",
          "name": "",
          "apt": "",
          "formattedAddressLine": "Wonderland Healing Center"
        },
        "formatted":
            "Wonderland Healing Center, Ko Pha-ngan, Ko Pha-ngan District, Surat Thani, Thailand",
        "country": "TH",
        "postalCode": "84280",
        "subdivision": "84"
      },
      "picture": "yuval_birman.jpg",
      "phone": "66651219899",
      "nickname": "Fluke"
    },
    {
      "id": "ziv_shalev",
      "itemType": "user",
      "email": "shallevziv@gmail.com",
      "lastName": "Shalev",
      "firstName": "Ziv",
      "address": {
        "subdivisions": [
          {
            "code": "Center District",
            "name": "Center District",
            "type": "ADMINISTRATIVE_AREA_LEVEL_1"
          },
          {"code": "Petach Tikva", "name": "Petach Tikva", "type": "ADMINISTRATIVE_AREA_LEVEL_2"},
          {
            "code": "Kokhav Ya'ir Tzur Yigal",
            "name": "Kokhav Ya'ir Tzur Yigal",
            "type": "ADMINISTRATIVE_AREA_LEVEL_3"
          },
          {"code": "IL", "name": "Israel", "type": "COUNTRY"}
        ],
        "city": "Kokhav Ya'ir Tzur Yigal",
        "location": {"latitude": 32.2318702, "longitude": 35.00897},
        "countryFullname": "Israel",
        "streetAddress": {"number": "34", "name": "Dan Street", "apt": ""},
        "formatted": "Dan Street 34, Kokhav Ya'ir Tzur Yigal, Israel",
        "country": "IL"
      },
      "picture": "ziv_shalev.jpg",
      "phone": "972525697025"
    }
  ].map(UserItem.fromFields).toList();
  static final listValues = [
    {
      "id": "domain_airCondioning",
      "itemType": "listValue",
      "name": "airCondioning",
      "description": "Issues related to air conditioning systems.",
      "title": "Air Conditioning",
      "type": "domain"
    },
    {
      "id": "domain_carpentry",
      "itemType": "listValue",
      "name": "carpentry",
      "description": "Repairs or work involving wood structures.",
      "title": "Carpentry",
      "type": "domain"
    },
    {
      "id": "domain_electricity",
      "itemType": "listValue",
      "name": "electricity",
      "description": "Issues related to electrical systems or wiring.",
      "title": "Electricity",
      "type": "domain"
    },
    {
      "id": "domain_it",
      "itemType": "listValue",
      "name": "it",
      "description": "Issues with computers, networks, or software.",
      "title": "IT",
      "type": "domain"
    },
    {
      "id": "domain_other",
      "itemType": "listValue",
      "name": "other",
      "description": "Issues that do not fall under any other domain.",
      "title": "Other",
      "type": "domain"
    },
    {
      "id": "domain_plumbing",
      "itemType": "listValue",
      "name": "plumbing",
      "description": "Issues involving water supply, drainage, sanitary systems, and pipework",
      "title": "Plumbing",
      "type": "domain"
    },
    {
      "id": "domain_roofing",
      "itemType": "listValue",
      "name": "roofing",
      "description": "Issues with roof/celing structures or leaks.",
      "title": "Roofing",
      "type": "domain"
    },
    {
      "id": "facilityStatus_notStarted",
      "itemType": "listValue",
      "name": "notStarted",
      "description": "Project not yet initiated.",
      "order": 1.0,
      "title": "Not Started",
      "type": "facilityStatus"
    },
    {
      "id": "facilityStatus_operational",
      "itemType": "listValue",
      "name": "operational",
      "description": "Facility is active and in regular use.",
      "order": 5.0,
      "title": "Operational",
      "type": "facilityStatus"
    },
    {
      "id": "facilityStatus_planning",
      "itemType": "listValue",
      "name": "planning",
      "description": "In design or approval phase before construction begins.",
      "order": 2.0,
      "title": "Planning",
      "type": "facilityStatus"
    },
    {
      "id": "facilityStatus_ready",
      "itemType": "listValue",
      "name": "ready",
      "description": "Construction completed; awaiting activation or inspection.",
      "order": 4.0,
      "title": "Ready",
      "type": "facilityStatus"
    },
    {
      "id": "facilityStatus_construction",
      "itemType": "listValue",
      "name": "construction",
      "description": "Construction work is currently in progress.",
      "order": 3.0,
      "title": "Under Construction",
      "type": "facilityStatus"
    },
    {
      "id": "facilitySubtype_a",
      "itemType": "listValue",
      "name": "a",
      "description": "Side A",
      "order": 1.0,
      "title": "A",
      "type": "facilitySubtype"
    },
    {
      "id": "facilitySubtype_b",
      "itemType": "listValue",
      "name": "b",
      "description": "Side B",
      "order": 2.0,
      "title": "B",
      "type": "facilitySubtype"
    },
    {
      "id": "facilityType_villa",
      "itemType": "listValue",
      "name": "villa",
      "description": "Villa",
      "title": "Villa",
      "type": "facilityType"
    },
    {
      "id": "ticketSeverity_critical",
      "itemType": "listValue",
      "name": "critical",
      "description": "Severe problem causing immediate disruption.",
      "order": 4.0,
      "title": "Critical",
      "type": "ticketSeverity"
    },
    {
      "id": "ticketSeverity_high",
      "itemType": "listValue",
      "name": "high",
      "description": "Major issue affecting important operations.",
      "order": 3.0,
      "title": "High",
      "type": "ticketSeverity"
    },
    {
      "id": "ticketSeverity_low",
      "itemType": "listValue",
      "name": "low",
      "description": "Minor issue with little or no impact.",
      "order": 1.0,
      "title": "Low",
      "type": "ticketSeverity"
    },
    {
      "id": "ticketSeverity_medium",
      "itemType": "listValue",
      "name": "medium",
      "description": "Noticeable problem needing attention.",
      "order": 2.0,
      "title": "Medium",
      "type": "ticketSeverity"
    },
    {
      "id": "ticketStatus_closed",
      "itemType": "listValue",
      "name": "closed",
      "description": "Ticket fully resolved and finalized.",
      "order": 6.0,
      "title": "Closed",
      "type": "ticketStatus"
    },
    {
      "id": "ticketStatus_done",
      "itemType": "listValue",
      "name": "done",
      "description": "Work completed, pending confirmation.",
      "order": 4.0,
      "title": "Done",
      "type": "ticketStatus"
    },
    {
      "id": "ticketStatus_inProgress",
      "itemType": "listValue",
      "name": "inProgress",
      "description": "Work on the ticket has started.",
      "order": 2.0,
      "title": "In Progress",
      "type": "ticketStatus"
    },
    {
      "id": "ticketStatus_new",
      "itemType": "listValue",
      "name": "new",
      "description": "Ticket created, not yet worked on.",
      "order": 1.0,
      "title": "New",
      "type": "ticketStatus"
    },
    {
      "id": "ticketStatus_on_hold",
      "itemType": "listValue",
      "name": "on_hold",
      "description": "Waiting for external input or dependency.",
      "order": 5.0,
      "title": "On Hold",
      "type": "ticketStatus"
    }
  ].map(ListValueItem.fromFields).toList();

  static final allItems = [...facilities, ...users, ...listValues];
}

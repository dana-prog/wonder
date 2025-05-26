import '../../data/item.dart';
import '../../data/metadata.dart';
import '../../logger.dart';
import 'client.dart';

const _itemsFields = <Map<String, dynamic>>[
  {
    "id": "fea40de8-8810-493b-8fcc-b2df84b105a4",
    "itemType": "facility",
    "number": 1.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "8d7690db-e65f-4a83-9c39-d42c6aff6939",
    "itemType": "facility",
    "number": 2.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 1.0,
    "status": "8c8807a4-0a24-418c-b026-cda0d1e919eb",
    "owner": "8862dcdd-d5c5-4ede-8441-46ffef12f617",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "629771d2-ce0f-4ef2-9170-32c6be7f7412",
    "itemType": "facility",
    "number": 3.0,
    "subtype": "41af2d26-7a9d-49f4-91f7-34f7965410e4",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "daf73e81-d0a9-4a0c-aedf-cadb4c7942a2",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "61da77cd-1112-4b41-b802-5fdd9d4a7e9d",
    "itemType": "facility",
    "number": 4.0,
    "subtype": "41af2d26-7a9d-49f4-91f7-34f7965410e4",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "1efa9f62-9870-472c-8452-ff2fab134a65",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "598e438b-2126-4eaa-be01-bbf4fd7f1f41",
    "itemType": "facility",
    "number": 5.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "26997034-e03f-4454-a7c7-14db903d39ec",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "247213f0-dd3e-480b-8566-7b2079f0c81e",
    "itemType": "facility",
    "number": 6.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 3.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "e1c31aa3-bfbc-4b6f-9b73-0983f30e876e",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "3c34ee55-05e0-4107-9cd1-b720fe494592",
    "itemType": "facility",
    "number": 7.0,
    "subtype": "41af2d26-7a9d-49f4-91f7-34f7965410e4",
    "roomCount": 2.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "b6c5a2aa-dcae-4725-82d7-41ddeb17ca7e",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "2ac0d955-ed37-4432-af0f-6d40c83cd0e3",
    "itemType": "facility",
    "number": 8.0,
    "subtype": "41af2d26-7a9d-49f4-91f7-34f7965410e4",
    "roomCount": 2.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "f8eb3bef-2821-4ead-8de8-5d78f6c5ca31",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "b6dc0622-a9be-4738-940d-fd2e18422d58",
    "itemType": "facility",
    "number": 9.0,
    "subtype": "41af2d26-7a9d-49f4-91f7-34f7965410e4",
    "roomCount": 3.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "add4462c-18ce-4720-8925-1b478c639f81",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "74403b51-1d2e-44e2-85cd-4ba002a568e6",
    "itemType": "facility",
    "number": 10.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 2.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "e7af2c89-34cd-4a26-844a-023609c4a48c",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "1d4bb57f-9fe5-484a-b014-bae38e83c76d",
    "itemType": "facility",
    "number": 11.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 3.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "4a57eb5c-3165-4504-b94b-95a76d140c4a",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "78b2b980-1ca2-41a9-a56c-8d5a73fcf648",
    "itemType": "facility",
    "number": 12.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 2.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "c8cbd709-bdb7-4fb7-8b83-49fa90d2ecfc",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "f9951c29-ead3-43d9-abed-2e879232e171",
    "itemType": "facility",
    "number": 13.0,
    "subtype": "41af2d26-7a9d-49f4-91f7-34f7965410e4",
    "roomCount": 3.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "b3ff3f15-b350-4f21-ad9f-0f64b57affda",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "edf7e866-b8e6-442e-ba93-8059a9506254",
    "itemType": "facility",
    "number": 14.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 2.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "dd97c5cf-add5-4381-8275-355c325e5468",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "4350d69e-de12-44b2-8d7d-71a7239a9b49",
    "itemType": "facility",
    "number": 15.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 2.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "46da4e21-19f4-42f5-acad-058a1545480f",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "5302d646-6c34-4dd2-ba15-2e742f59f4a5",
    "itemType": "facility",
    "number": 16.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 2.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "21d1bd5a-b6e8-4241-919f-63d5e3baa6a0",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "2c7f344a-d6db-4e25-b100-f4150da1cb65",
    "itemType": "facility",
    "number": 47.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "64973716-e729-41b2-9e93-a2401bd8156d",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "8ad7e0da-145b-4141-a9d8-d6361fbe9ed5",
    "itemType": "facility",
    "number": 48.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "0e8a9886-ba80-4b47-bb18-6418d4fb6068",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "fd5ea459-0c68-4de5-836e-343c423c32a8",
    "itemType": "facility",
    "number": 49.0,
    "subtype": "41af2d26-7a9d-49f4-91f7-34f7965410e4",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "316c3d79-7031-4d7a-b4be-89baf3ba097b",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "8fa13f1b-8f0a-4345-a6e2-aca0b6ede037",
    "itemType": "facility",
    "number": 51.0,
    "subtype": "41af2d26-7a9d-49f4-91f7-34f7965410e4",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "7cbcdc85-ed6d-4b2d-a4e5-dfe6790fa2a0",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "ae20e1b8-58c2-49a4-9f2b-19961c0bbc6c",
    "itemType": "facility",
    "number": 52.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "8d84565a-0f31-4e9f-8ba6-c94536df4a71",
    "itemType": "facility",
    "number": 53.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 3.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "6fbc5088-e80b-498c-9012-511962ef5026",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "e91be65e-5f36-40da-8c7b-73a4ed8d4a95",
    "itemType": "facility",
    "number": 54.0,
    "subtype": "41af2d26-7a9d-49f4-91f7-34f7965410e4",
    "roomCount": 3.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "aa01710f-2c1c-4d73-893a-cad95cc6955a",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "58ebb352-daaf-4bb0-9767-6557330b8bd2",
    "itemType": "facility",
    "number": 55.0,
    "subtype": "41af2d26-7a9d-49f4-91f7-34f7965410e4",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "5cb3bb32-fec6-4a9e-bb4a-db4f8274d64a",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "1ed09f94-92ea-4725-b477-63bb4cec0cf7",
    "itemType": "facility",
    "number": 56.0,
    "subtype": "41af2d26-7a9d-49f4-91f7-34f7965410e4",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "94e4c703-c4d5-419e-9973-de1245dcf54d",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "578cfb81-fe35-4b5d-a664-991336044722",
    "itemType": "facility",
    "number": 57.0,
    "subtype": "41af2d26-7a9d-49f4-91f7-34f7965410e4",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "d87e94ab-8ce4-4eac-8a1c-8103969d0b3a",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "b98d31cf-01b4-4fb5-92b4-32dffd8f3137",
    "itemType": "facility",
    "number": 64.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "pictures": [
      "https://static.wixstatic.com/media/1246fe_45611c767be14754b1eb59c98f693937~mv2.jpg"
    ],
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "00df2d48-2337-48e8-af52-a620cd767c7f",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "f05e5f0a-7f9f-4f6a-9993-0a9d803ba9bd",
    "itemType": "facility",
    "number": 65.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "fee5fbad-f297-4b96-bb6b-69afe3fbfdbb",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "72f245fd-3a51-4138-bc46-da485456c447",
    "itemType": "facility",
    "number": 66.0,
    "subtype": "41af2d26-7a9d-49f4-91f7-34f7965410e4",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "b536852e-c87d-4004-bb18-ddd8edaa73f7",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "926401ba-1b39-486c-8994-bc9a1f7711fa",
    "itemType": "facility",
    "number": 67.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "70b11947-84a8-45bc-aa27-6c29b41a6a00",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "f5402f8c-f161-4eab-aa59-9c98eab4c9ef",
    "itemType": "facility",
    "number": 69.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "21aa79c5-5103-4ae1-9edc-833daa953d18",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "5adcb03a-0e84-4f27-b80e-4364ded1d97c",
    "itemType": "facility",
    "number": 70.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "9b155891-7611-4816-8ee7-09e6ad58149d",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "7cdcb800-26ff-4d7a-9cc1-bb9bf9fec1b4",
    "itemType": "facility",
    "number": 71.0,
    "subtype": "41af2d26-7a9d-49f4-91f7-34f7965410e4",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "aab3a5b3-32b6-4586-ac88-1e9996a39510",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "6d47a61c-8b83-40cc-9650-d3a06dd905be",
    "itemType": "facility",
    "number": 72.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "f0d7cfc6-2b21-415f-800c-ae912cc6167e",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "726d6576-2ff4-4f42-8ce1-8930959d34ca",
    "itemType": "facility",
    "number": 73.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "2bbef897-80c4-4f2f-9cc4-ec0a9813a2a0",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "1a9cf4fa-d589-4f73-baa6-d05a95601d7e",
    "itemType": "facility",
    "number": 74.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "14b14788-eac7-4612-a6b1-c2ecaee868e2",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "2a75aa0e-2be4-4c5a-8227-9e9d57d11a3e",
    "itemType": "facility",
    "number": 75.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "7ba320cc-5b31-4211-b54b-ea90f42fcd85",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "33bed98d-dd1f-407b-aee1-a78377339444",
    "itemType": "facility",
    "number": 76.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "7b186f9f-b7da-46fb-a28e-6eb27318ebf3",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "9bc3acb0-ae98-48e7-9ae2-7f754d43fce3",
    "itemType": "facility",
    "number": 77.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 3.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "c97d0fdc-4361-43df-80b7-a06ab4591deb",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "9232f146-389f-484f-99ab-9bff5102fd54",
    "itemType": "facility",
    "number": 87.0,
    "subtype": "41af2d26-7a9d-49f4-91f7-34f7965410e4",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "3fc3d495-ab88-4a22-8ef1-80fcc8e8b9eb",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "ee5e6bd4-a547-4bb4-b67c-ed8c28dd0480",
    "itemType": "facility",
    "number": 88.0,
    "subtype": "41af2d26-7a9d-49f4-91f7-34f7965410e4",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "03902f1f-6827-4dcf-ada1-174a1c04b80b",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "6a2622ab-d0e9-4b2a-97db-b8659f84168d",
    "itemType": "facility",
    "number": 89.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "a932229d-09e7-4801-83cc-a0e0c35943c2",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "287da818-09b2-4b56-bcee-e732706380b5",
    "itemType": "facility",
    "number": 90.0,
    "subtype": "258ff7a8-a983-4d69-9682-28621500803f",
    "roomCount": 1.0,
    "status": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "owner": "852bf296-f76d-4f81-8343-ff272113de78",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "d74372fc-4fc9-429e-b456-531d5dbb5491",
    "itemType": "facility",
    "number": 93.0,
    "subtype": "41af2d26-7a9d-49f4-91f7-34f7965410e4",
    "roomCount": 5.0,
    "status": "d5718b65-755a-4127-a30e-f44fd1ed768e",
    "owner": "75846fe5-96d9-47d1-895e-57ea245fee4a",
    "type": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444"
  },
  {
    "id": "00df2d48-2337-48e8-af52-a620cd767c7f",
    "itemType": "user",
    "middleName": "Shai",
    "email": "igal.daiboch@gmail.com",
    "lastName": "Daiboch",
    "firstName": "Igal",
    "address": {
      "subdivisions": [
        {"code": "จ.สุราษฎร์ธานี", "name": "สุราษฎร์ธานี", "type": "ADMINISTRATIVE_AREA_LEVEL_1"},
        {"code": "อำเภอเกาะพะงัน", "name": "อำเภอเกาะพะงัน", "type": "ADMINISTRATIVE_AREA_LEVEL_2"},
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
    "id": "6b31c377-97f4-4d25-9d8d-106eec5a38bc",
    "itemType": "listValue",
    "name": "airCondioning",
    "description": "Issues related to air conditioning systems.",
    "title": "Air Conditioning",
    "type": "domain"
  },
  {
    "id": "9c267a30-0e90-43c9-a5bb-9bc4f875b026",
    "itemType": "listValue",
    "name": "carpentry",
    "description": "Repairs or work involving wood structures.",
    "title": "Carpentry",
    "type": "domain"
  },
  {
    "id": "8043f515-043c-4f8e-ac78-e2896e203edb",
    "itemType": "listValue",
    "name": "electricity",
    "description": "Issues related to electrical systems or wiring.",
    "title": "Electricity",
    "type": "domain"
  },
  {
    "id": "76d37a78-e97e-4047-b938-e56b3448a094",
    "itemType": "listValue",
    "name": "it",
    "description": "Issues with computers, networks, or software.",
    "title": "IT",
    "type": "domain"
  },
  {
    "id": "5ec790ba-40a5-45c2-988c-26ecf02eb15e",
    "itemType": "listValue",
    "name": "other",
    "description": "Issues that do not fall under any other domain.",
    "title": "Other",
    "type": "domain"
  },
  {
    "id": "9bc778dd-247b-4d7f-9b55-e2dfd5f16b4e",
    "itemType": "listValue",
    "name": "plumbing",
    "description": "Issues involving water supply, drainage, sanitary systems, and pipework",
    "title": "Plumbing",
    "type": "domain"
  },
  {
    "id": "357acd92-92c3-49b3-9ee1-f18ecba570f6",
    "itemType": "listValue",
    "name": "roofing",
    "description": "Issues with roof/celing structures or leaks.",
    "title": "Roofing",
    "type": "domain"
  },
  {
    "id": "ca8bcd2d-edd1-415a-aa6a-9cd338227f25",
    "itemType": "listValue",
    "name": "notStarted",
    "description": "Project not yet initiated.",
    "order": 1.0,
    "title": "Not Started",
    "type": "facilityStatus"
  },
  {
    "id": "8c8807a4-0a24-418c-b026-cda0d1e919eb",
    "itemType": "listValue",
    "name": "operational",
    "description": "Facility is active and in regular use.",
    "order": 5.0,
    "title": "Operational",
    "type": "facilityStatus"
  },
  {
    "id": "d5718b65-755a-4127-a30e-f44fd1ed768e",
    "itemType": "listValue",
    "name": "planning",
    "description": "In design or approval phase before construction begins.",
    "order": 2.0,
    "title": "Planning",
    "type": "facilityStatus"
  },
  {
    "id": "934e57a7-d5e1-4018-b1f4-2ec6bc4b45e4",
    "itemType": "listValue",
    "name": "ready",
    "description": "Construction completed; awaiting activation or inspection.",
    "order": 4.0,
    "title": "Ready",
    "type": "facilityStatus"
  },
  {
    "id": "126cd917-9ee1-45a7-8bdf-190ed1f67e3c",
    "itemType": "listValue",
    "name": "underConstruction",
    "description": "Construction work is currently in progress.",
    "order": 3.0,
    "title": "Under Construction",
    "type": "facilityStatus"
  },
  {
    "id": "41af2d26-7a9d-49f4-91f7-34f7965410e4",
    "itemType": "listValue",
    "name": "a",
    "description": "Side A",
    "order": 1.0,
    "title": "A",
    "type": "facilitySubtype"
  },
  {
    "id": "258ff7a8-a983-4d69-9682-28621500803f",
    "itemType": "listValue",
    "name": "b",
    "description": "Side B",
    "order": 2.0,
    "title": "B",
    "type": "facilitySubtype"
  },
  {
    "id": "d9c1d2a1-17fe-4f3f-b035-dcbe4905e444",
    "itemType": "listValue",
    "name": "villa",
    "description": "Villa",
    "title": "Villa",
    "type": "facilityType"
  },
  {
    "id": "ef4b98ef-22a1-4f9d-8d45-23064f2f7677",
    "itemType": "listValue",
    "name": "critical",
    "description": "Severe problem causing immediate disruption.",
    "order": 4.0,
    "title": "Critical",
    "type": "ticketSeverity"
  },
  {
    "id": "15a6e911-929e-49b1-b96d-34f09e0c01c7",
    "itemType": "listValue",
    "name": "high",
    "description": "Major issue affecting important operations.",
    "order": 3.0,
    "title": "High",
    "type": "ticketSeverity"
  },
  {
    "id": "1df17d9f-847a-4319-b333-850c3546caa5",
    "itemType": "listValue",
    "name": "low",
    "description": "Minor issue with little or no impact.",
    "order": 1.0,
    "title": "Low",
    "type": "ticketSeverity"
  },
  {
    "id": "ef3c9e46-c319-46bf-9c8b-d21b1fea6ee7",
    "itemType": "listValue",
    "name": "medium",
    "description": "Noticeable problem needing attention.",
    "order": 2.0,
    "title": "Medium",
    "type": "ticketSeverity"
  },
  {
    "id": "2ce460dd-9af8-41f0-b9d9-d69fed336aa5",
    "itemType": "listValue",
    "name": "closed",
    "description": "Ticket fully resolved and finalized.",
    "order": 6.0,
    "title": "Closed",
    "type": "ticketStatus"
  },
  {
    "id": "2813969b-cd24-401f-b47a-06fdc03f4426",
    "itemType": "listValue",
    "name": "done",
    "description": "Work completed, pending confirmation.",
    "order": 4.0,
    "title": "Done",
    "type": "ticketStatus"
  },
  {
    "id": "e92f13c9-c2f1-4c66-ab2a-19edb51525bf",
    "itemType": "listValue",
    "name": "inProgress",
    "description": "Work on the ticket has started.",
    "order": 2.0,
    "title": "In Progress",
    "type": "ticketStatus"
  },
  {
    "id": "1763222c-9206-4388-8b7d-946b18ad33ef",
    "itemType": "listValue",
    "name": "new",
    "description": "Ticket created, not yet worked on.",
    "order": 1.0,
    "title": "New",
    "type": "ticketStatus"
  },
  {
    "id": "5c9884df-9d67-490f-a637-184a64422321",
    "itemType": "listValue",
    "name": "on_hold",
    "description": "Waiting for external input or dependency.",
    "order": 5.0,
    "title": "On Hold",
    "type": "ticketStatus"
  },
  {
    "id": "46da4e21-19f4-42f5-acad-058a1545480f",
    "itemType": "user",
    "email": "a@alexzak.me",
    "lastName": "Zak",
    "firstName": "Alex"
  },
  {
    "id": "c8cbd709-bdb7-4fb7-8b83-49fa90d2ecfc",
    "itemType": "user",
    "email": "tesnom333@gmail.com",
    "lastName": "Kuchar",
    "firstName": "Alexander"
  },
  {
    "id": "94e4c703-c4d5-419e-9973-de1245dcf54d",
    "itemType": "user",
    "email": "Aly.hazlewood@gmail.com",
    "lastName": "hazlewood",
    "firstName": "Aly"
  },
  {
    "id": "03902f1f-6827-4dcf-ada1-174a1c04b80b",
    "itemType": "user",
    "email": "aboulard@mac.com",
    "lastName": "Boulard",
    "firstName": "Arnauld"
  },
  {
    "id": "a932229d-09e7-4801-83cc-a0e0c35943c2",
    "itemType": "user",
    "email": "Asaf.yigal@gmail.com",
    "lastName": "Yigal",
    "firstName": "Asaf"
  },
  {
    "id": "dd97c5cf-add5-4381-8275-355c325e5468",
    "itemType": "user",
    "middleName": "Kefi Ep",
    "email": "wshoucair@gmail.com",
    "lastName": "Shoucair",
    "firstName": "Baha"
  },
  {
    "id": "70b11947-84a8-45bc-aa27-6c29b41a6a00",
    "itemType": "user",
    "email": "benmar71@gmail.com",
    "lastName": "Markus",
    "firstName": "Binyamin"
  },
  {
    "id": "aab3a5b3-32b6-4586-ac88-1e9996a39510",
    "itemType": "user",
    "email": "Bashbash1111@gmail.com",
    "lastName": "Haroni",
    "firstName": "Bishara"
  },
  {
    "id": "b536852e-c87d-4004-bb18-ddd8edaa73f7",
    "itemType": "user",
    "email": "boaz_birman@gmail.com",
    "lastName": "Birman",
    "firstName": "Boaz",
    "address": {
      "subdivisions": [
        {"code": "จ.สุราษฎร์ธานี", "name": "สุราษฎร์ธานี", "type": "ADMINISTRATIVE_AREA_LEVEL_1"},
        {"code": "อำเภอเกาะพะงัน", "name": "อำเภอเกาะพะงัน", "type": "ADMINISTRATIVE_AREA_LEVEL_2"},
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
    "picture": "https://static.wixstatic.com/media/1246fe_d1dee5a0ef654c58922dea570e9a40a7~mv2.jpg",
    "phone": "66651219799"
  },
  {
    "id": "f8eb3bef-2821-4ead-8de8-5d78f6c5ca31",
    "itemType": "user",
    "email": "cbuettner@live.com",
    "lastName": "Buettne",
    "firstName": "Christian"
  },
  {
    "id": "8181be09-6da8-4216-a611-8380c5eacab8",
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
    "picture": "https://static.wixstatic.com/media/1246fe_b56c192a93b243c9a59a37ba02f26aee~mv2.jpg",
    "phone": "972548145556"
  },
  {
    "id": "b3ff3f15-b350-4f21-ad9f-0f64b57affda",
    "itemType": "user",
    "email": "eliyaba@gmail.com",
    "lastName": "Ben Ari",
    "firstName": "David"
  },
  {
    "id": "c97d0fdc-4361-43df-80b7-a06ab4591deb",
    "itemType": "user",
    "email": "Erez@tamarail.co.il",
    "lastName": "Zaichic",
    "firstName": "Erez"
  },
  {
    "id": "316c3d79-7031-4d7a-b4be-89baf3ba097b",
    "itemType": "user",
    "email": "egbenari@gmail.com",
    "lastName": "Ben Ari",
    "firstName": "Esther"
  },
  {
    "id": "b6c5a2aa-dcae-4725-82d7-41ddeb17ca7e",
    "itemType": "user",
    "email": "Tohar13@hotmail.com",
    "lastName": "Haimovich",
    "firstName": "Evelin"
  },
  {
    "id": "4a57eb5c-3165-4504-b94b-95a76d140c4a",
    "itemType": "user",
    "email": "anatnevo20@gmail.com",
    "lastName": "Zaichic",
    "firstName": "Eyal"
  },
  {
    "id": "21d1bd5a-b6e8-4241-919f-63d5e3baa6a0",
    "itemType": "user",
    "email": "gadbaum@gmail.com",
    "lastName": "Baum",
    "firstName": "Gad"
  },
  {
    "id": "fee5fbad-f297-4b96-bb6b-69afe3fbfdbb",
    "itemType": "user",
    "email": "guybena@gmail.com",
    "lastName": "Ben Ami",
    "firstName": "Guy"
  },
  {
    "id": "7b186f9f-b7da-46fb-a28e-6eb27318ebf3",
    "itemType": "user",
    "email": "guyreg3@gmail.com",
    "lastName": "Regev",
    "firstName": "Guy"
  },
  {
    "id": "8862dcdd-d5c5-4ede-8441-46ffef12f617",
    "itemType": "user",
    "email": "Henning.Helmich@gmx.net",
    "lastName": "Helmich",
    "firstName": "Henning"
  },
  {
    "id": "3fc3d495-ab88-4a22-8ef1-80fcc8e8b9eb",
    "itemType": "user",
    "email": "Idochalten@gmail.com",
    "lastName": "Keinan",
    "firstName": "Ido"
  },
  {
    "id": "1efa9f62-9870-472c-8452-ff2fab134a65",
    "itemType": "user",
    "middleName": "Aniela",
    "email": "Pbyrne7@bigpond.com",
    "lastName": "Dwyer",
    "firstName": "Jane"
  },
  {
    "id": "add4462c-18ce-4720-8925-1b478c639f81",
    "itemType": "user",
    "email": "_tmpleebirman@gmail.com",
    "lastName": "Birman",
    "firstName": "Lee",
    "nickname": "Yellow"
  },
  {
    "id": "d87e94ab-8ce4-4eac-8a1c-8103969d0b3a",
    "itemType": "user",
    "email": "lilaclopezco@gmail.com",
    "lastName": "Lopez",
    "firstName": "Lilac"
  },
  {
    "id": "2bbef897-80c4-4f2f-9cc4-ec0a9813a2a0",
    "itemType": "user",
    "middleName": "Barbara",
    "email": "luisa.nebel@me.com",
    "lastName": "Nebel",
    "firstName": "Luisa"
  },
  {
    "id": "daf73e81-d0a9-4a0c-aedf-cadb4c7942a2",
    "itemType": "user",
    "middleName": "Rosario Ines P.",
    "email": "macky.lovina@gmail.com",
    "lastName": "Lovina",
    "firstName": "Maria"
  },
  {
    "id": "4ac2fa73-a242-4877-a594-0283c052137e",
    "itemType": "user",
    "middleName": "Alfred",
    "email": "nils@4fr.de",
    "lastName": "Patzer",
    "firstName": "Michael"
  },
  {
    "id": "9b155891-7611-4816-8ee7-09e6ad58149d",
    "itemType": "user",
    "email": "michael0390@gmail.com",
    "lastName": "Rosen",
    "firstName": "Michael"
  },
  {
    "id": "e7af2c89-34cd-4a26-844a-023609c4a48c",
    "itemType": "user",
    "email": "michalrote@gmail.com",
    "lastName": "Rotem",
    "firstName": "Michal"
  },
  {
    "id": "7ec1f3d1-06bc-4267-a39e-42ba8764e11e",
    "itemType": "user",
    "email": "navanavax@gmail.com",
    "lastName": "Sanders",
    "firstName": "Nava"
  },
  {
    "id": "64973716-e729-41b2-9e93-a2401bd8156d",
    "itemType": "user",
    "email": "noga.polansky@gmail.com",
    "lastName": "Polansky",
    "firstName": "Noga"
  },
  {
    "id": "e1c31aa3-bfbc-4b6f-9b73-0983f30e876e",
    "itemType": "user",
    "email": "oferrotem@gmail.com",
    "lastName": "Rotem",
    "firstName": "Ofer"
  },
  {
    "id": "5cb3bb32-fec6-4a9e-bb4a-db4f8274d64a",
    "itemType": "user",
    "email": "patpita999@gmail.com",
    "lastName": "Chiozza",
    "firstName": "Patrizia"
  },
  {
    "id": "0e8a9886-ba80-4b47-bb18-6418d4fb6068",
    "itemType": "user",
    "email": "roy.ben.abraham@gmail.com",
    "lastName": "Ben Abraham",
    "firstName": "Roy"
  },
  {
    "id": "7cbcdc85-ed6d-4b2d-a4e5-dfe6790fa2a0",
    "itemType": "user",
    "email": "Sha900@gmail.com",
    "lastName": "Cohen",
    "firstName": "Shachar"
  },
  {
    "id": "14b14788-eac7-4612-a6b1-c2ecaee868e2",
    "itemType": "user",
    "email": "SHAI@SHABASTV.COM",
    "lastName": "Ben Saadon",
    "firstName": "Shai"
  },
  {
    "id": "26997034-e03f-4454-a7c7-14db903d39ec",
    "itemType": "user",
    "middleName": "Uli",
    "email": "uli@eau.co.il",
    "lastName": "Constantini",
    "firstName": "Shmuel"
  },
  {
    "id": "21aa79c5-5103-4ae1-9edc-833daa953d18",
    "itemType": "user",
    "email": "trillium765@gmail.com",
    "lastName": "Seafyre",
    "firstName": "Trillium"
  },
  {
    "id": "852bf296-f76d-4f81-8343-ff272113de78",
    "itemType": "user",
    "email": "Kaplan.tzvika@gmail.com",
    "lastName": "Kaplan",
    "firstName": "Tzvi"
  },
  {
    "id": "6fbc5088-e80b-498c-9012-511962ef5026",
    "itemType": "user",
    "email": "yaronweber@gmail.com",
    "lastName": "Weber",
    "firstName": "Yaron",
    "address": {
      "subdivisions": [
        {"code": "จ.สุราษฎร์ธานี", "name": "สุราษฎร์ธานี", "type": "ADMINISTRATIVE_AREA_LEVEL_1"},
        {"code": "อำเภอเกาะพะงัน", "name": "อำเภอเกาะพะงัน", "type": "ADMINISTRATIVE_AREA_LEVEL_2"},
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
    "picture": "https://static.wixstatic.com/media/1246fe_f917449ddcb84ed281370647d928dd54~mv2.jpg",
    "phone": "66651219699",
    "nickname": "John"
  },
  {
    "id": "7ba320cc-5b31-4211-b54b-ea90f42fcd85",
    "itemType": "user",
    "email": "ykoevary@gmail.com",
    "lastName": "Covary",
    "firstName": "Yonathan"
  },
  {
    "id": "aa01710f-2c1c-4d73-893a-cad95cc6955a",
    "itemType": "user",
    "email": "yutdoe@gmail.com",
    "lastName": "Doe",
    "firstName": "Yut"
  },
  {
    "id": "f0d7cfc6-2b21-415f-800c-ae912cc6167e",
    "itemType": "user",
    "email": "flokichokdee@gmail.com",
    "lastName": "Birman",
    "firstName": "Yuval",
    "address": {
      "subdivisions": [
        {"code": "จ.สุราษฎร์ธานี", "name": "สุราษฎร์ธานี", "type": "ADMINISTRATIVE_AREA_LEVEL_1"},
        {"code": "อำเภอเกาะพะงัน", "name": "อำเภอเกาะพะงัน", "type": "ADMINISTRATIVE_AREA_LEVEL_2"},
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
    "picture": "https://static.wixstatic.com/media/1246fe_a714ce3ce72e472398c1864b77be8d2f~mv2.jpg",
    "phone": "66651219899",
    "nickname": "Fluke"
  },
  {
    "id": "75846fe5-96d9-47d1-895e-57ea245fee4a",
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
    "picture": "https://static.wixstatic.com/media/1246fe_d3abff9ea20646038b7024bb899d0bad~mv2.jpg",
    "phone": "972525697025"
  }
];

class LocalDevClient extends Client {
  final _metadata = Metadata();

  final Map<String, Item> _itemsById = {};
  final Map<String, List<Item>> _itemsByType = {};

  LocalDevClient() {
    for (final itemFields in _itemsFields) {
      final String itemType = itemFields['itemType']!;
      final item = _metadata.getByName(itemType).deserializer(itemFields);
      _itemsById[item.id] = item;
      _itemsByType.putIfAbsent(itemType, () => []);
      _itemsByType[itemType]!.add(item);
    }
  }

  @override
  Future<T> fetchItem<T extends Item>({
    required String itemType,
    required String id,
  }) async {
    logger.t('[LocalDevClient.fetchItem] $itemType/$id');
    return _itemsById[id] as T;
  }

  @override
  Future<List<T>> fetchItems<T extends Item>({required String itemType}) async {
    logger.t('[LocalDevClient.fetchItems] $itemType');
    return _itemsByType[itemType]?.cast<T>() ?? [];
  }

  @override
  Future<T> updateItem<T extends Item>(T item) async {
    logger.t('[LocalDevClient.updateItem] item: $item');
    final updatedItem = (_itemsById[item.id] ?? item) as T;

    for (MapEntry<String, dynamic> field in item.fields.entries) {
      updatedItem[field.key] = field.value;
    }
    _itemsById[item.id] = updatedItem;
    notifyItemUpdated(updatedItem);
    return updatedItem;
  }

  @override
  Future<T> deleteItem<T extends Item>({
    required String itemType,
    required String id,
  }) async {
    logger.t('[LocalDevClient.deleteItem] $itemType/$id');

    final deletedItem = _itemsById.remove(id)!;
    _itemsByType[itemType]!.removeWhere((item) => item.id == id);
    notifyItemDeleted(deletedItem);
    return deletedItem as T;
  }
}

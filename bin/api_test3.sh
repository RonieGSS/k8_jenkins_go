#!/bin/bash

curl -u "ad9a320tny349h8s0gs3f08b4210h4ac89vb91:" -X GET http://localhost:50190/apiExternal/clients/3\?\&keyword\=テスト\&limit\=5

#{
#  "message": "success",
#  "result": {
#    "prev": "",
#    "next": "http://localhost:50190/apiExternal/clients/3?page=2&limit=5&keyword=テスト",
#    "amount": 25,
#    "page": 1,
#    "limit": 5,
#    "data": [
#      {
#        "address": "埼玉県川口市上青木５丁目２４番９号",
#        "company_no": "7030001078381",
#        "department": "テスト部署",
#        "email": "a@qmu.jp",
#        "id": 3,
#        "name": "株式会社テスト",
#        "note": "備考",
#        "person_in_charge": "担当者1",
#        "tel": "03-1234-5678"
#      },
#      {
#        "address": "埼玉県川口市上青木５丁目２４番９号",
#        "company_no": "7030001078381",
#        "department": "テスト部署",
#        "email": "a@qmu.jp",
#        "id": 4,
#        "name": "株式会社テスト",
#        "note": "備考",
#        "person_in_charge": "担当者2",
#        "tel": "03-1234-5678"
#      },
#      {
#        "address": "埼玉県川口市上青木５丁目２４番９号",
#        "company_no": "7030001078381",
#        "department": "テスト部署",
#        "email": "a@qmu.jp",
#        "id": 5,
#        "name": "株式会社テスト",
#        "note": "備考",
#        "person_in_charge": "担当者3",
#        "tel": "03-1234-5678"
#      },
#      {
#        "address": "埼玉県川口市上青木５丁目２４番９号",
#        "company_no": "7030001078381",
#        "department": "テスト部署",
#        "email": "a@qmu.jp",
#        "id": 6,
#        "name": "株式会社テスト",
#        "note": "備考",
#        "person_in_charge": "担当者4",
#        "tel": "03-1234-5678"
#      },
#      {
#        "address": "埼玉県川口市上青木５丁目２４番９号",
#        "company_no": "7030001078381",
#        "department": "テスト部署",
#        "email": "a@qmu.jp",
#        "id": 7,
#        "name": "株式会社テスト",
#        "note": "備考",
#        "person_in_charge": "担当者5",
#        "tel": "03-1234-5678"
#      }
#    ]
#  },
#  "status": 200
#}


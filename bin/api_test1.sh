#!/bin/bash

 curl -u "ad9a320tny349h8s0gs3f08b4210h4ac89vb91:" -X POST http://localhost:50190/apiExternal/createInvoice  -d data='{
    "user_id" :                 1,
    "amount" :                  10000,
    "tax" :                     100,
    "issued_date" :             "2018-08-20",
    "due_date" :                "2018-08-20",
    "company_no":               9010401106130,
    "company_address":          "東京都港区西麻布1-11-10",
    "company_name":             "株式会社くむ",
    "company_department":       "テスト部署",
    "company_person_in_charge": "田村佳也",
    "company_tel":              "08059018175" ,
    "company_email":            "a@qmu.j" 
 }' 

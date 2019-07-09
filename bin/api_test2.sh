#!/bin/bash

 curl -u "ad9a320tny349h8s0gs3f08b4210h4ac89vb91:" -X POST http://localhost:50190/apiExternal/registerAccount  -d data='{
    "user_id"       : 1,
    "incorporated"  : false,
    "email"         : "a@qmu.jp",
    "tel"           : "08059018175",
    "family_name"   : "田村",
    "first_name"    : "佳也",
    "family_name_kana"      : "タムラ",
    "first_name_kana"       : "ヨシヤ",
    "pen_name"              : "ペンネーム太郎",
    "business_name"         : "屋号ああああ",
    "business_name_kana"    : "ヤゴウアアアア",
    "birth_day"             : "1988-05-06",
    "master_gender_id"      : 1,
    "zipcode"               : "1060031",
    "master_prefecture_id"  : 13,
    "city"                  : "港区",
    "address"               : "西麻布1-11-10",
    "building"              : "ビルマーサ201",
    "master_industry_id"    : 1,
    "industry_years"        : 5,
    "company_name"          : "株式会社くむ",
    "company_name_kana"     : "カブシキガイシャクム",
    "company_no"            : 9010401106130,
    "company_tel"           : "0364470744",
    "represent_family_name" : "田村",
    "represent_first_name"  : "佳也",
    "represent_family_name_kana"    : "タムラ",
    "represent_first_name_kana"     : "ヨシヤ",
    "established_year"              : 6,
    "num_employee"                  : 2,
    "capital"                       : 1000000,
    "sales_last_year"               : 20000000,
    "in_debt"                       : true,
    "in_debt_from"                  : 1,
    "in_debt_amount"                : 1000000,
    "ave_invoice_sales"             : 500000,
    "ave_monthly_sales"             : 2000000,
    "bank_name"                     : "三菱UFJ銀行",
    "bank_code"                     : "1",
    "branch_name"                   : "月島支店",
    "branch_code"                   : "1",
    "master_account_type_id"        : 1,
    "account_no"                    : "123456",
    "account_name"                  : "タムラヨシヤ",
    "alternated_anshin_account_name": true,
    "anshin_account_name"           : "タムラヨシヤ"
 }'

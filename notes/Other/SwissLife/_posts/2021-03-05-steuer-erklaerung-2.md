---
layout: post
title: 瑞士報稅不專業經驗分享(中)
date: 2021-03-05
---

## 前言

[上篇](/notes/other/swisslife/2021/02/06/steuer-erklaerung-1){:target="_blank"}簡單介紹了持有長短期居留證的外國人，在瑞士必須或自願報稅的原因，以及在非必要的情況下，填寫稅單的利與弊分析。

原本僅打算寫上、下兩篇，但由於個人拖延症發作（？），決定再加個中篇，簡單講解報稅表格有哪些項目，以及如何試算大約繳交多少稅金。

一樣要再次聲明：這篇文章主要目的是寫下對報稅相關細節的筆記，我**個人對於瑞士的稅法並無涉獵，也非法律相關背景**，只是在瑞士報稅第三年的軟體工程師，且我的情況相對單純（膝下無子、沒有不動產、沒有投資、沒有負債、沒有額外收入），對於報稅的各個項目了解程度極度有限，因此本文所有內容皆為不專業分享，大部份資訊也是從網路上及個人經驗得到，若有任何穆誤敬請見諒及不吝指教、更正。

另外由於瑞士每個州都有不同的規定，我只能以我住的聖加侖州來講解、盡我所能將德文翻譯為中文。法語區、義大利語區、或是德語區其他州的相關規定就不在我能力範圍內了。

## 更多的稅務知識

這邊補充一些後面可能會用到的稅務相關知識。

### 繳稅給誰？

瑞士的所得稅分別要繳交給聯邦政府（Direkte Bundessteuer **直接聯邦稅**）、州政府及市鎮（Kantons- und Gemeindesteuer **州與市鎮稅**）。而財富稅（Vermögenssteuer）則只繳交給州與市鎮。

## 源頭稅計算因素

計算直接從薪水扣繳所得稅的考慮因素包括：

* 居住地的州
* 婚姻狀態（已婚 / 單身）
* 子女數量、是否同住
* 薪水

而計算稅率分為兩種模型：`按月計算`及`按年計算`的模型。目前只有 FR、GE、TI、VD、VS 這五個州是採用按年計算的模型。

按月計算的壞處是：若在同一個月領到第十三個月的薪水，當月的稅率會依「兩倍月薪 * 12」當作年薪去計算當月稅率，因此可能會比平均分攤在十二個月後所計算的年薪要繳納更高的稅金。

聖加侖州 2020 年的源頭稅分為 A、B、C、D、H 五個稅率 [[ref: Tarife --> Quellensteuertarife 2020]](https://www.sg.ch/steuern-finanzen/steuern/formulare-wegleitungen/quellensteuern.html){:target="_blank"}：

* **A 稅率**：單身者月收入稅率（Monatstarif für Alleinstehende）[[ref]](https://www.sg.ch/content/dam/sgch/steuern-finanzen/steuern/formulare-und-wegleitungen/quellensteuer/tarife/2020/Tarif%20A%202020%20Final.pdf){:target="_blank"}，適用於單身、分居、離婚或喪偶的納稅人。
* **B 稅率**：已婚、單薪者的月收入稅率（Monatstarif für verheiratete Alleinverdiener）[[ref]](https://www.sg.ch/content/dam/sgch/steuern-finanzen/steuern/formulare-und-wegleitungen/quellensteuer/tarife/2020/Tarif%20B%202020%20Final.pdf){:target="_blank"}，適用於已婚、同居、只有一人工作。
* **C 稅率**：已婚、雙薪者的月收入稅率（Monatstarif für verheiratete Doppelverdiener）[[ref]](https://www.sg.ch/content/dam/sgch/steuern-finanzen/steuern/formulare-und-wegleitungen/quellensteuer/tarife/2020/Tarif%20C%202020%20Final.pdf){:target="_blank"}，適用於已婚、同居、雙方都受僱的情況。
* **D 稅率**：副業收入或替代收入的月收入稅率，從 Merkblatt 51.5.1 文件上看來，應該為單一稅率 10%（[[ref: 第六頁 4.2 D-Tarif: Linearer Steuersatz von 10% der Bruttoeinkünfte.]](https://www.sg.ch/content/dam/sgch/steuern-finanzen/steuern/formulare-und-wegleitungen/quellensteuer/merkbl%C3%A4tter-wegleitungen/51.5.1%20Merkblatt%20%C3%BCber%20die%20Quellenbesteuerung%20von%20Ersatzeink%C3%BCnften_1.1.2020.pdf){:target="_blank"}
* **H 稅率**：單身、但同一家庭有需要撫養者的月收入稅率（Monatstarif für Alleinstehende mit unterstützungsbedürftigen Personen im gleichen Haushalt）[[ref]](https://www.sg.ch/content/dam/sgch/steuern-finanzen/steuern/formulare-und-wegleitungen/quellensteuer/tarife/2020/Tarif%20H%202020%20%20Final.pdf){:target="_blank"}，適用於單身、分居、離婚或喪偶，但有同住子女或需撫養同住家人的納稅人。

因此，計算主要收入稅率的第一步便是根據婚姻狀態、單薪或雙薪、以及是否撫養子女等資訊選擇適用的稅率表。點進去表格後，前四頁為「簡短」的稅率計算解釋及注意事項（Erläuterungen und Hinweise），其中第二項稅率分類的表格概括了稅率是如何分類的：

<div style="text-align: center;"><img src="/images/steuererklaerung_ch/tarifeinstufung.png" style="width: 100%; max-width: 800px" /><br/>👆 稅率分類</div>

上圖主要根據<span style="background-color: #fedbd5">**是否有宗教**</span>分為上、下兩個表格（紅框部份），每個表格各有兩大直欄，分別為<span style="background-color: #fed8ab">**單身**</span>及<span style="background-color: #d4e3fd">**已婚**</span>，單身欄又分為有子女、無子女；已婚欄則分為單薪、雙薪。雖然雙薪欄下還分為丈夫及妻子（註），但從稅碼看來稅率是沒有差別的。而橫列則為<span style="background-color: #b2dc90">**子女數量**</span>，從子女數量 0 至 5 分別有不同的稅率。

註：許久以前曾在網路上看過貼文，提到若是雙薪皆扣源頭稅，同樣的收入，妻子會扣比丈夫更重的稅，因為是以丈夫的收入佔家庭收入更高的比重去計算的稅率。所以這規定可能真的存在過，但已經廢除了。

從表格也不難看出，適用的稅率代碼由三個代碼組成：第一個英文字母為婚姻及子女狀態對應的稅率表（A、B、C、或 H），第二個數字為子女數量（0 至 5），第三個英文字母為有無宗教（Y 或 N）。這個代碼也可以在薪資單中找到（例：`Quellensteuerabzug 1.1 - 31.1 - SG / A0N`）。

第五頁看起來是雇主需要為源頭稅的員工輸入的所得表單範例，上面也可以看到居住地州及市鎮（Kt.、Wohnsitzgemeinde）、薪資收入（Brutto-Lohn）、津貼、福利收入（Zulagen, Nebenleistungen）、稅率欄（Tarif）、子女數量（Anzahl Kinder）等等，皆關係到稅率計算。範例中，稅率欄有 AN（單身、無宗教）、AY（單身、有宗教）、BY（已婚單薪、有宗教）、CY（雙薪、有宗教）及D（替代收入或兼職收入）等等，皆是上面提到的代碼。

<div style="text-align: center;"><img src="/images/steuererklaerung_ch/sg_quellensteuer_monats_und_quartalsabrechnung.jpg" style="width: 100%; max-width: 400px" /><br/>👆 雇主填寫的預扣稅表單</div>

第六頁（右下角頁碼 1）至十七頁（右下角頁碼 12）為需要繳宗教稅的稅率，其餘則為不需繳宗教稅的稅率：

<div style="text-align: center;"><img src="/images/steuererklaerung_ch/sg_quellensteuer_tarif_a_mit_kirchensteuer.png" style="width: 100%; max-width: 600px" /><br/>👆 含宗教稅的稅率表</div>
<div style="text-align: center;"><img src="/images/steuererklaerung_ch/sg_quellensteuer_tarif_a_ohne_kirchensteuer.png" style="width: 100%; max-width: 600px" /><br/>👆 無宗教稅的稅率表</div>

基本上源頭稅可以直接透過查表得到對應的稅率。

值得一提的是，若是在同一個月內分次領取本薪及第十三個月的薪水，第一次領取時會以當次領取薪資計算對應的稅率，第二次以上則是以當月已領取總和計算當月的稅率，再扣掉當月已預扣的所得稅，便可得到當次應扣稅額。

## 一般稅率計算因素

稅率計算相較源頭稅要考慮的因素更多、更細，包括：

* 居住地的州及市鎮
* 婚姻狀態（已婚 / 單身）
* 自己及伴侶宗教（天主教、福音教、基督教、其他或無）
* 全年應稅所得（總收入減去可扣除支出）
  - 註：州及市鎮稅的可扣除支出項目計算方式與聯邦稅不同，因此計算出來的所得淨額會不一樣。例如我今年的工作費用扁平費率扣除額（Berufskosten Pauschalabzug）計算出來分別為 2400（州與市鎮）及 2984（聯邦）瑞郎、保險費用扣抵上限分別為 6400 及 3500 瑞郎等等。
* 年底時的應稅資產（資產減去負債）
  - 註：瑞士是世界上少數還在課「財富稅」的國家
* 子女數及撫養人口數（稅率不變，但聯邦稅會根據子女及撫養人口數減免金額 251 瑞郎乘上人數 [[ref]](https://www.fedlex.admin.ch/eli/cc/1991/1184_1184_1184/de#art_36){:target="_blank"}）。

根據以上狀況，便可查表或輸入稅金計算機（Steuerkalkulator）計算總稅金，例如聖加侖州提供的線上試算 [[ref]](https://www.sg.ch/content/sgch/steuern-finanzen/steuern/steuerkalkulator/privatperson.html){:target="_blank"}。

瑞士跟大部份國家一樣都採`累進稅率`，也就是收入及資產越高、稅率越高。所得稅及財富稅分開計算稅率。 [[ref]](https://www.expatica.com/ch/finance/taxes/switzerland-tax-rates-101589/){:target="_blank"}

### 所得（Einkünfte）怎麼計算？

一般的情況下，若不是自僱者，每年年初會從人資那邊收到薪資證明（Lohnausweis / Certificat de salaire / Certificato di salario）：

<div style="text-align: center;"><a href="/images/steuererklaerung_ch/lohnausweis.jpg" target="_blank"><img src="/images/steuererklaerung_ch/lohnausweis.jpg" style="width: 100%; max-width: 400px" /></a><br/>👆 薪資證明（點擊新視窗檢視圖片）</div>

上面會列出<span style="border: 3px solid #4691fa">全年薪資收入</span>（1.）、<span style="border: 3px solid #4691fa">其他福利、津貼項目</span>（2. 至 7.）、<span style="border: 3px solid #4691fa">收入總和</span>（8.）、<span style="border: 3px solid #9ed080">扣除職業保險支出</span>（9.）、<span style="border: 3px solid #9ed080">扣除提繳職業養老金</span>（10.）、<span style="border: 3px solid #fcaf35">淨收入</span>（11.；等於 8. 減去 9.、10. 後的差）、<span style="border: 3px solid #9465f9">預扣所得稅</span>（12.）、<span style="border: 3px solid #26ccfa">工作相關費用報銷</span>（13.） [[ref]](https://www.estv.admin.ch/dam/estv/de/dokumente/bundessteuer/formulare/lohnausweis/la-wegleitung-2021.pdf.download.pdf/la-wegleitung-2021.pdf){:target="_blank"} 等等。最後一部份是指公司在上班期間發生的費用報銷，例如出差的機票、餐費等等，詳情我其實也看不太懂，有興趣可參考 ref。

**一般報稅所填寫的收入為第 11 項的<span style="border: 3px solid #fcaf35">淨收入</span>**，而預扣所得稅計算的收入則為每月<span style="border: 3px solid #4691fa">扣掉保險費及退休金前的毛薪資</span>（對應稅單第 1 項）計算相對應的所得稅率。

除了主要工作收入外，應稅收入項目還包括許多來源，例如：兼職收入、董事會出席費用及津貼、自僱收入、退休養老金收入、失業補助、未包含在工資表上的家庭津貼、動產收入、房地產收入、其他收入、贍養費、未分配遺產收入、等等。上述所得的總和便為`總收入`。

### 可扣除的費用（Abzüge）怎麼計算？

這裡「可扣除」的費用是指「可」從所得中「扣除」的費用。這裡的金額越高，最後應稅所得會越低。

可扣除的費用則較廣，聖加侖州的包含：**非自僱者工作費用**（Berufskosten）、債務利息、贍養費、**支付第三支柱養老金**、額外購買第二支柱養老金、**保險費支出**、房地產維護及行政支出、**財富管理費用**、**育兒費用支出**、政黨支出、**就業導向培訓支出**、高額疾病及意外支出（大於淨收入 2%）、殘疾相關費用、慈善捐款、子女或撫養家人扣除額、子女教育費用、雙薪扣除額 [[ref]](https://blog.migrosbank.ch/de/diese-abzuege-sollte-sie-keinesfalls-vergessen/){:target="_blank"} 等等。

每個州能扣除的項目不盡相同，沃州（VD）及楚格州（ZG）甚至能扣除租金支出 [[ref]](https://blog.migrosbank.ch/de/diese-abzuege-sollte-sie-keinesfalls-vergessen/){:target="_blank"}！

每個項目都有各自的起始值及上限，例如聖加侖州的稅單都會附上如下圖的扣除費用上限表。

<div style="text-align: center;"><img src="/images/steuererklaerung_ch/abzug_max.jpg" style="width: 100%; max-width: 600px" /><br/>👆 聖加侖州的扣除費用上限</div>

若是手寫稅單可能會需要對照一下此表，但若是使用報稅軟體則不需要擔心上限，扣除費用超過上限時軟體會自動帶入上限值。

### 應稅所得怎麼計算？

基本概念為：`應稅收入 = 收入 - 支出`。但其中又根據扣除的項目分為三種 [[ref]](https://blog.migrosbank.ch/de/diese-abzuege-sollte-sie-keinesfalls-vergessen/){:target="_blank"}：
* Nettoeinkommen（淨收入）：收入總額減去扣除額（不包含醫療費用及慈善捐款的「額外扣除額」）
* Reineinkommen（純收入？不知道怎麼翻比較好）：淨收入減去額外扣除額（醫療費用及慈善捐款）
* Steuerbares Einkommen（應稅收入）：純收入減去社會扣除額（Sozialabzüge），例如：根據婚姻狀況、子女數、撫養人口數的扣除額。

下圖為聖加侖州的報稅軟體產生的報表：

<div style="text-align: center;"><a href="/images/steuererklaerung_ch/steuerbares_einkommen.jpg" target="_blank"><img src="/images/steuererklaerung_ch/steuerbares_einkommen.jpg" style="width: 100%; max-width: 400px" /></a><br/>👆 應稅所得計算（點擊新視窗檢視圖片）</div>

報表中正是列出：
* <span style="border: 3px solid #1bb4e3">基本扣除項目</span>、<span style="border: 3px solid #1bb4e3">基本扣除項目總額（Total Abzüge）</span>、<span style="border: 3px solid #ec5c50">淨收入（Nettoeinkommen）</span>
* <span style="border: 3px solid #1bb4e3">額外扣除項目</span>、<span style="border: 3px solid #ec5c50">純收入（Reineinkommen）</span>
* <span style="border: 3px solid #1bb4e3">社會扣除項目</span>、<span style="border: 3px solid #ec5c50">應稅收入（Steuerbares Einkommen）</span>、<span style="border: 3px solid #ec5c50">取下限至百位數的應稅收入</span>（例如：56'789 -> 56'000）

右方則分兩欄：<span style="border: 3px solid #fea92a">州與市鎮</span>、<span style="border: 3px solid #b9c43f">聯邦</span>。分別為計算州與市鎮稅以及聯邦稅的可扣除額（可扣除額項目及上限皆不同）。

### 應稅資產（Vermögen）怎麼計算？

資產項目包括：**證券及銀行存款**、現金、黃金、貴金屬、養老保險、**汽機車**、未分配繼承份額、房地產、自僱企業資產。

資產也有「扣除額」，也就是負債（Schulden）的部份：私人債務及企業債務。

`淨資產`的計算方式則為：`總資產 - 總負債`。而`應稅淨資產`則是`淨資產 - 社會扣除額（Sozialabzüge）`；聖加侖州的社會扣除額為單身 75'000 瑞郎、夫妻 150'000 瑞郎、每位子女再加上 20'000 瑞郎。

由於我個人的資產不到被扣稅的程度也並無負債，這個部份無法寫太多細節。

### 所得稅怎麼計算？

計算完應稅收入（Steuerbares Einkommen）後，便可在各州稅務局提供的計算機中輸入州與市鎮的應稅收入及聯邦的應稅收入，以便試算應繳所得稅，例如下圖的紅框部份：

<div style="text-align: center;"><img src="/images/steuererklaerung_ch/steuerkalkulator.jpg" style="width: 100%; max-width: 600px" /><br/>👆 聖加侖州的所得稅及財富稅計算機</div>

## 結語

這篇筆記主要總結了源頭稅及一般報稅的計算方式。或許對「報」稅尚無直接幫助，但能更了解報稅的內容以及稅率計算方式。簡單來說，若要節稅最主要的重點就是申報越多扣除項目越好。下一篇預計是聖加侖州報稅軟體的操作筆記。


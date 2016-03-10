# git 小技巧

## 美化 git log
```git log``` 檢視以前版本的資訊不太好看，輸入以下
```
git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
```
以後就可以 ```git lg``` 看到漂亮好看的版本樹惹

## 用 git pull --rebase
我們的情況應該會都是在同一個支幹上開發。  
一般的 ```git pull``` 是抓(fetch)完檔案後用 merge 的，如果你原本的狀態與 github 上的不一樣，就會產生新的節點。就變成分之在合併的情況。  
故用 ```git pull --rebase``` 類似補丁的方式把遠端的修改補丁在原本的樹上。讓樹保持好看。

## 如何檢視版本差異
```git diff``` 後面參數不同可以有不同的應用，若是要比對 ```git status``` 裡c紅紅的那些，也就是想知道自己到底改了什麼的話
```
git diff -- 檔名
```
這會比對紅紅的與**最新版本**（所以是你新加的檔案是無法比較的）  
若想知道各 commit 到底改了什麼建議直接上 github ，commit 點進去後可以看該 commit 改了那裡惹

## 如何讓 git status 裡紅紅的消失
可能你不小心動到了你沒有要動的檔案之類的...  
- Case 新加的檔案：直接把那個檔案刪掉就好
- Case 本來就有的檔案：```git checkout -- 檔名```，這會讓該檔案回到最新版本的狀態  

## 如何讓 git status 裡綠綠的變回紅紅的
可能你不想在這次的 commit 裡加入這個修改之類的...  
```
git reset HEAD 檔名
```

## 如何回到過去的版本
```git lg``` 找到你想回去的版本亂碼
```git checkout 版本亂碼``` 可以回到任意想去的版本  
```git checkout master``` 可以變回到原來最新的狀態  


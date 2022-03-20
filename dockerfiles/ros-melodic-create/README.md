# 使い方

## 起動

- Dockerインストール済みの環境を用意

- スクリプトを起動
``` 
.build-docker-image.bash
```

− run-docker-image.bashをエディタで開き、countainar_nameの値を書き換える。

− 初回起動
``` 
./run-docker-image.bash
```

− 一度起動したあとは、Docker のコマンドで起動する。

```
docker start countainar_name
```

※docker ps -a コマンドでコンテナ名が確認できる。

## Navigationまで

参考:[HARD2021：シミュレータで地図作成からナビゲーションまでしよう！](https://demura.net/robot/hard/20061.html)

- Gazebo worldを起動する。

```
roslaunch ca_gazebo create_house.launch
```

- rviz の起動
```
roslaunch ca_tools rviz.launch
```

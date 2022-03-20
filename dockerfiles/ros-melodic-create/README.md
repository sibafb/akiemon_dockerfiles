# 使い方

## 起動

- Dockerインストール済みの環境を用意

- スクリプトを起動
``` 
.build-docker-image.bash
```

- run-docker-image.bashをエディタで開き、countainar_nameの値を書き換える。

- 初回起動
``` 
./run-docker-image.bash
```

- 一度起動したあとは、Docker のコマンドで起動する。

```
docker start countainar_name
```

※docker ps -a コマンドでコンテナ名が確認できる。

## Navigationまで

参考:[HARD2021：シミュレータで地図作成からナビゲーションまでしよう！](https://demura.net/robot/hard/20061.html)

- 環境変数を設定する。（起動モードを環境変数で切り替える設定になっている。）

```
export LOCALIZATION=amcl
export RVIZ_CONFIG=navigation
```

- Gazebo worldを起動する。
　※worldは起動したいものに書き換える

```
roslaunch ca_gazebo create_house.launch
```

- rviz の起動
```
roslaunch ca_tools rviz.launch
```

- RViz の2D Nav Goalから ゴールポイントを指定すると、動作する。

# トラブルシュート

- GoalをPublishしてもNavigationが走らない
  - createのライブラリが名前空間を/create1としているのでデフォルトのrvizの２D Nav Goalだと反応しない
  - RViz -> Panels -> Tool Properties から 2D Nav GoalのTopicを、 /move_base_simple/goal -> /create1/move_base_simple/goal と変更

- launch時のエラー
  - 以下のようなエラー, source していないので行う
```
RLException: [create_house.launch] is neither a launch file in package [ca_gazebo] nor is [ca_gazebo] a launch file name
The traceback for the exception was written to the log file
```

```
source devel/setup.bash
```

- ImuのLibraryエラー

- 以下のエラー
  - 現状未解決、RVizのDisplay Topicから外せば出なくなる。
```
[ERROR] [1647763450.270201498, 1182.706000000]: PluginlibFactory: The plugin for class 'rviz_plugin_tutorials/Imu' failed to load.  Error: According to the loaded plugin descriptions the class rviz_plugin_tutorials/Imu with base class type rviz::Display does not exist. Declared types are  rtabmap_ros/Info rtabmap_ros/MapCloud rtabmap_ros/MapGraph rviz/Axes rviz/Camera rviz/DepthCloud rviz/Effort rviz/FluidPressure rviz/Grid rviz/GridCells rviz/Illuminance rviz/Image rviz/InteractiveMarkers rviz/LaserScan rviz/Map rviz/Marker rviz/MarkerArray rviz/Odometry rviz/Path rviz/PointCloud rviz/PointCloud2 rviz/PointStamped rviz/Polygon rviz/Pose rviz/PoseArray rviz/PoseWithCovariance rviz/Range rviz/RelativeHumidity rviz/RobotModel rviz/TF rviz/Temperature rviz/WrenchStamped
```

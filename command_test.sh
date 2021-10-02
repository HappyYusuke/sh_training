#!/bin/sh

# evalコマンドは文字列を評価後に連結して、現在のシェルに実行させる
# eval(evaluate:評価する)

command="roslaunch megarover_samples vmegarover_with_sample_world.launch"
eval $command

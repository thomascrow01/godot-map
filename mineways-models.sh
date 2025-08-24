#!/bin/bash

echo -e "Minecraft world: ../../Desktop/mcserverbackup-26-09-2024/worldOfRegions\nZoom: 1\nSimplify mesh: yes\nSet render type: Wavefront OBJ absolute indices\nFill air bubbles: no; Seal off entrances: no; Fill in isolated tunnels in base of model: yes\nCreate block faces at the borders: no\nUse biomes: YES\nCenter model: yes\nTree leaves solid: yes\n" > temporary.mwscript

for ((x = $1; x <= $2; x++)); do

    for ((y = $3; y <= $4; y++)); do

        echo -e "Selection location: $((x * 128)), 0, $((y * 128)) to $((128 + x * 128)), 255, $((128 + y * 128))\nSelect minimum height: 0\nExport for Rendering: export/$((x))_$((y)).obj" >> temporary.mwscript
#Select minimum height: V # this doesnt work with the center model as the heights will not allign
        
    done

done

echo -e "Close" >> temporary.mwscript

wine Mineways.exe -m -s none temporary.mwscript
rm temporary.mwscript

echo Done

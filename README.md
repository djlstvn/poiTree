# poiTree

This is a small music visualization/animation artwork written with Processing.

To run it, you need:
1. **Processing 3.3.x** and **minim library**.
2. The complete **poiTree folder** and files within.
3. Put the mp3 file you want you play along in the **poiTree** folder, then change the file name string in **setup() function in poiTree.pde** to that of your mp3 file:
```
song = minim.loadFile("*.mp3", 1024);
```

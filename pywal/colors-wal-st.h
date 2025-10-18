const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0d151f", /* black   */
  [1] = "#445293", /* red     */
  [2] = "#4B5A9C", /* green   */
  [3] = "#54788F", /* yellow  */
  [4] = "#5D839B", /* blue    */
  [5] = "#61869D", /* magenta */
  [6] = "#678CA2", /* cyan    */
  [7] = "#c2c4c7", /* white   */

  /* 8 bright colors */
  [8]  = "#5c6571",  /* black   */
  [9]  = "#445293",  /* red     */
  [10] = "#4B5A9C", /* green   */
  [11] = "#54788F", /* yellow  */
  [12] = "#5D839B", /* blue    */
  [13] = "#61869D", /* magenta */
  [14] = "#678CA2", /* cyan    */
  [15] = "#c2c4c7", /* white   */

  /* special colors */
  [256] = "#0d151f", /* background */
  [257] = "#c2c4c7", /* foreground */
  [258] = "#c2c4c7",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;

static const char norm_fg[] = "#c2c4c7";
static const char norm_bg[] = "#0d151f";
static const char norm_border[] = "#5c6571";

static const char sel_fg[] = "#c2c4c7";
static const char sel_bg[] = "#4B5A9C";
static const char sel_border[] = "#c2c4c7";

static const char urg_fg[] = "#c2c4c7";
static const char urg_bg[] = "#445293";
static const char urg_border[] = "#445293";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};

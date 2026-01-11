static const int delay = 5;
static const char *statsep = " | ";
static const char *timefmt = "%a %d %b -- %H:%M:%S";
static const char *sysbat = "/sys/class/power_supply/BAT0";
static const char *syscur = "charge_now";
static const char *sysfull = "charge_full_design";
static const unsigned int sndcrd = 0;
static const char* swtchname = "Master Playback Switch";
static const char* volumname = "Master Playback Volume";

static size_t batcapmay(char *dest, size_t n) {
  size_t ret;
  static int hasbat = -1;

  if (hasbat == -1) {
    if (access(sysbat, F_OK)) {
      hasbat = 0;
      return 0;
    }
    hasbat = 1;
  } else if (!hasbat) {
    return 0;
  }

  ret = batcap(dest, n);
  if (ret)
    ret += separator(&dest[ret], n - ret);

  return ret;
}

static size_t (* const sfuncs[])(char*, size_t) = {
  batcapmay,
  loadavg,
  separator,
  curtime,
};

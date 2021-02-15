class SemesterData {
  int getSemesterValue(String semester) {
    if (semester == 'semester1') {
      return 1;
    } else if (semester == 'semester2') {
      return 2;
    } else if (semester == 'semester3') {
      return 3;
    } else if (semester == 'semester4') {
      return 4;
    } else if (semester == 'semester5') {
      return 5;
    } else if (semester == 'semester6') {
      return 6;
    } else if (semester == 'semester7') {
      return 7;
    } else {
      return 8;
    }
  }
}

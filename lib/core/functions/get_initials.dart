String getInitials(String value) {
  return value.substring(0, 1) + value.split(" ").last.substring(0, 1);
}

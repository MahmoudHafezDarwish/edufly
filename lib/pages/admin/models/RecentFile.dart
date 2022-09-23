import 'package:Design/gen/assets.gen.dart';

class RecentFile {
  final String? icon, title, date, size;
  bool? isAccept;

  RecentFile({
    this.icon,
    this.title,
    this.date,
    this.size,
    this.isAccept,
  });
}

List demoRecentFiles = [
  RecentFile(
      icon: Assets.icons.xdFile,
      title: "مهدي",
      date: "01-03-2021",
      size: "مقبول",
      isAccept: true),
  RecentFile(
    icon: Assets.icons.xdFile,
    title: "عبدالرحمن",
    date: "27-02-2021",
    size: "مقبول",
    isAccept: true,
  ),
  RecentFile(
    icon: Assets.icons.xdFile,
    title: "مصعب",
    date: "23-02-2021",
    size: "مرفوض",
    isAccept: false,
  ),
  RecentFile(
    icon: Assets.icons.xdFile,
    title: "محمد",
    date: "21-02-2021",
    size: "مرفوض",
    isAccept: false,
  ),
  RecentFile(
    icon: Assets.icons.xdFile,
    title: "خالد",
    date: "23-02-2021",
    size: "مرفوض",
    isAccept: false,
  ),
  RecentFile(
    icon: Assets.icons.xdFile,
    title: "محمود",
    date: "25-02-2021",
    size: "مرفوض",
    isAccept: false,
  ),
  RecentFile(
    icon: Assets.icons.xdFile,
    title: "خالد",
    date: "25-02-2021",
    size: "مقبول",
    isAccept: true,
  ),
  RecentFile(
    icon: Assets.icons.xdFile,
    title: "خالد",
    date: "25-02-2021",
    size: "مقبول",
    isAccept: true,
  ),
  RecentFile(
    icon: Assets.icons.xdFile,
    title: "خالد",
    date: "25-02-2021",
    size: "مرفوض",
    isAccept: false,
  ),
  RecentFile(
    icon: Assets.icons.xdFile,
    title: "خالد",
    date: "25-02-2021",
    size: "مرفوض",
    isAccept: false,
  ),
];

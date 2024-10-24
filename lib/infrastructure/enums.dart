enum Gender { male, female }

enum Currency { usd, eur, sr }

enum DialogStatus { done, accept, cancel, rate, report }

enum Status { onhold, accepted, denied, paid, finished }

enum ChatType { txtmsg, image, location }

enum ImageType { network, local }

extension StatusString on DialogStatus {
  String get icon {
    switch (this) {
      case DialogStatus.done:
        return 'assets/icons/done.svg';
      case DialogStatus.accept:
        return 'assets/icons/accept.svg';
      case DialogStatus.cancel:
        return 'assets/icons/cancel.svg';
      case DialogStatus.rate:
        return 'assets/icons/rate.svg';
      case DialogStatus.report:
        return 'assets/icons/report.svg';
      default:
        return 'assets/icons/done.svg';
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/proposals_db.dart';

final propsDBProvider = Provider<PropsDB>((ref) {
  return PropsDB(ref);
});

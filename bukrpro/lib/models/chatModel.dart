class Chatmodel {
  final int? id;
  final String? name;
  final String? lastmsg;
  final List<String?> msglist;

  Chatmodel({
    required this.id,
    required this.lastmsg,
    required this.name,
    required this.msglist,
  });
}

List<Chatmodel> Messages = [
  Chatmodel(
      id: 1,
      name: 'dilajbar',
      lastmsg: 'hloo',
      msglist: ['hii', 'how are u', 'fine']),
  Chatmodel(
      id: 2,
      name: 'sameer',
      lastmsg: 'come',
      msglist: ['hii', 'how are u', 'fine']),
  Chatmodel(
      id: 3,
      name: 'Abhijith',
      lastmsg: 'have anice ',
      msglist: ['hii', 'how are u', 'fine']),
  Chatmodel(
      id: 4,
      name: 'sumesh',
      lastmsg: 'kloo',
      msglist: ['hii', 'how are u', 'fine']),
  Chatmodel(
      id: 5,
      name: 'ragav',
      lastmsg: 'have anice ',
      msglist: ['hii', 'how are u', 'fine']),
];

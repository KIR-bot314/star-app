// Настройки синхронизации. Это единственный файл, который нужно править после создания проекта Firebase.
//
// firebase — объект firebaseConfig из консоли Firebase
//            (шестерёнка → Project settings → Your apps → Web app → SDK setup and configuration).
//            Обязательно должно быть поле databaseURL — адрес Realtime Database.
//            Пока здесь null, приложение работает локально, без синхронизации между телефонами.
//
// room     — случайное имя «комнаты» в базе. В правилах базы (Rules) разрешён доступ
//            только к rooms/<room>, поэтому имя должно совпадать с тем, что в правилах.

window.STAR_CONFIG = {
  firebase: null,
  room: 'hXZzRoFouLMW0HimIPyZIEypOSOz'
};

// Настройки синхронизации. Это единственный файл, который нужно править после создания проекта Firebase.
//
// firebase — объект firebaseConfig из консоли Firebase
//            (шестерёнка → Project settings → Your apps → Web app → SDK setup and configuration).
//            Обязательно должно быть поле databaseURL — адрес Realtime Database.
//            Ключ apiKey у веб-приложений Firebase публичный по замыслу; доступ к данным
//            ограничивают правила базы (Rules), а не этот ключ.
//
// room     — случайное имя «комнаты» в базе. В правилах базы (Rules) разрешён доступ
//            только к rooms/<room>, поэтому имя должно совпадать с тем, что в правилах.

window.STAR_CONFIG = {
  firebase: {
    apiKey: "AIzaSyAJfp1_chPO0sud0kGIjgP6C8lrex0OUAA",
    authDomain: "star-app-ff57b.firebaseapp.com",
    databaseURL: "https://star-app-ff57b-default-rtdb.europe-west1.firebasedatabase.app",
    projectId: "star-app-ff57b",
    storageBucket: "star-app-ff57b.firebasestorage.app",
    messagingSenderId: "380977932424",
    appId: "1:380977932424:web:f2c5c8c50d2efa46ab973d"
  },
  room: 'hXZzRoFouLMW0HimIPyZIEypOSOz'
};

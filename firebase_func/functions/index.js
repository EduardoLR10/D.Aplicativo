const functions = require('firebase-functions');
const admin = require('firebase-admin')

admin.initializeApp(functions.config().firebase);

var msgData;

exports.interesseTrigger = functions.firestore.document(
    'animals/{animalId}').onUpdate((change,context) => {
        const newValue = change.after.data();

        const previousValue = change.before.data();

        //if (newValue.interessados.lenght() > previousValue.interessados.lenght())
        //{
            admin.firestore().collection('animals').get().then((snapshots) => {
                var token = 'eKRhuFtEoxI:APA91bFOunDz0aHroQrei04xg8oscSQOyagA2owvMSDTC6GlPCZHNJtNU15aZG-Dusb1t-YJkCk2ycwxvF2j95q3P8M9kmsSN-3raO5FuOjqTyZzEWFFy5NNUUWloJnIRbZH9yNbVBFK';
                if(snapshots.empty) {
                    console.log('No animals')
                }
                else {
                    var payload = {
                        "notification": {
                            "title": "Novo interessado em Nele", //+ newValue.nome,
                            "body": "Verificar interessados",
                        },
                        	"data": {
                        		"sound": "default",
                        		"click_action" : "FLUTTER_NOTIFICATION_CLICK",
                        		"screen" : "ADOTARPAGE1",
                        }
                    }
                    return admin.messaging().sendToDevice (token, payload).then((response) => {
                                                console.log('BomV');
                                             }).catch((err) => {
                                                console.log(err);
                                             })
                }
             })
       // }
    })

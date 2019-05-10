const functions = require('firebase-functions');
const admin = require('firebase-admin')

admin.initializeApp(functions.config().firebase);

var msgData;

exports.interesseTrigger = functions.firestore.document(
	'animals/{animalId}').onUpdate((change,context) => {
		const newValue = change.after.data();

		const previousValue = change.before.data();

		admin.firestore().collection('users').doc(newValue.dono.id).get().then(doc => {
			var token;

			if(!doc.exists) {
				console.log('Sem dono');
			}
			else {
				token = doc.data().token;

				if (newValue.available != previousValue.available)
				{

					var payload = {
						"notification": {
							"title": "Confirmada a sua adoção do pet " + newValue.nome,
							"body": "Boa sorte!",
						},
						"data": {
							"sound": "default",
							"click_action" : "FLUTTER_NOTIFICATION_CLICK",
							"screen" : "ADOTARPAGE1",
						}
					}
					return admin.messaging().sendToDevice (token, payload).then((response) => {
						console.log('Enviada notificação');
					}).catch((err) => {
						console.log(err);})
				}
				else if (newValue.interessados.sources > previousValue.interessados.sources)
				{
					var payload = {
						"notification": {
							"title": "Novo interessado no seu pet " + newValue.nome,
							"body": "Por favor, verificar interessados",
						},
						"data": {
							"sound": "default",
							"click_action" : "FLUTTER_NOTIFICATION_CLICK",
							"screen" : "ADOTARPAGE1",
						}
					}
					return admin.messaging().sendToDevice (token, payload).then((response) => {
						console.log('Enviada notificação');
					}).catch((err) => {
						console.log(err);})
				}
			}
		})
	})

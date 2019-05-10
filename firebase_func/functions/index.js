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
							"screen" : "MYPETSPAGE",
						}
					}
					return admin.messaging().sendToDevice (token, payload).then((response) => {
						console.log('Enviada notificação');
					}).catch((err) => {
						console.log(err);})
				}
				else
				{
					var payload = {
						"notification": {
							"title": "Mudança em interessado no seu pet " + newValue.nome,
							"body": "Por favor, verificar interessados",
						},
						"data": {
							"sound": "default",
							"click_action" : "FLUTTER_NOTIFICATION_CLICK",
							"screen" : "MYPETSPAGE",
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
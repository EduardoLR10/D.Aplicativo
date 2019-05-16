const functions = require('firebase-functions');
const admin = require('firebase-admin')

admin.initializeApp(functions.config().firebase);

var msgData;

exports.notificacaoTrigger = functions.database.ref('animals/{animalId}')
.onUpdate((change,context) => {

	const newValue = change.after.val();
	const previousValue = change.before.val();

	var ref_dono = 'users/' + newValue.dono;

	admin.database().ref(ref_dono).on('value',
		function(user) {
			var token;

			if(!user.exists)
				return 1;

			else{
				token = user.val().token;

				console.log(newValue.interessados.length);

				if(newValue.available != previousValue.available)
				{
					var payload = {
						"notification": {
							"title": "Confirmada a sua adoção do pet " + newValue.nome,
							"body": "Boa sorte " + user.val().nome_user +"!",
						},
						"data": {
							"sound": "default",
							"click_action" : "FLUTTER_NOTIFICATION_CLICK",
							"screen" : "MYPETSPAGE",
						}
						} // payload

						admin.messaging().sendToDevice (token, payload).then((response) => {
							console.log('Enviada notificação');
						}).catch((err) => {
							console.log(err);})

					} //if available

					else if (newValue.interessados != null && newValue.interessados.length > previousValue.interessados.length)
					{
						var payload = {
							"notification": {
								"title": "Novo interessado em seu pet " + newValue.nome,
								"body": "Por favor, verificar interessados",
							},
							"data": {
								"sound": "default",
								"click_action" : "FLUTTER_NOTIFICATION_CLICK",
								"screen" : "MYPETSPAGE",
							}
						} // payload

						admin.messaging().sendToDevice (token, payload).then((response) => {
							console.log('Enviada notificação');
						}).catch((err) => {
							console.log(err);})
					}

					else if (newValue.interessados != null && newValue.interessados.length < previousValue.interessados.length)
					{
						var ref_inter = 'users/' + previousValue.interessados[previousValue.interessados.length - 1].user_uid;

						admin.database().ref(ref_inter).on('value',
							function(interessado) {

								token = interessado.val().token;
								var payload = {
									"notification": {
										"title": "Pedido de adocao cancelado ",
										"body": "Não aceito seu pedido de adoção de " + newValue.nome,
									},
									"data": {
										"sound": "default",
										"click_action" : "FLUTTER_NOTIFICATION_CLICK",
										"screen" : "ADOTARPAGE1",
									}
								} // payload

						admin.messaging().sendToDevice (token, payload).then((response) => {
							console.log('Enviada notificação');
						}).catch((err) => {
							console.log(err);})

						})
					}

					return 0;
				} //else
			}) // ref_dono
	}) // onUpdate

//exports.interesseTrigger = functions.firestore.document(
//	'animals/{animalId}').onUpdate((change,context) => {
//		const newValue = change.after.data();
//
//		const previousValue = change.before.data();
//
//		admin.firestore().collection('users').doc(newValue.dono.id).get().then(doc => {
//			var token;
//
//			if(!doc.exists) {
//				console.log('Sem dono');
//			}
//			else {
//				token = doc.data().token;
//
//				if (newValue.available != previousValue.available)/]
//				{
//					var payload = {
//						"notification": {
//							"title": "Confirmada a sua adoção do pet " + newValue.nome,
//							"body": "Boa sorte!",
//						},
//						"data": {
//							"sound": "default",
//							"click_action" : "FLUTTER_NOTIFICATION_CLICK",
//							"screen" : "MYPETSPAGE",
//						}
//					}
//					return admin.messaging().sendToDevice (token, payload).then((response) => {
//						console.log('Enviada notificação');
//					}).catch((err) => {
//						console.log(err);})
//				}
//				else
//				{
//					var payload = {
//						"notification": {
//							"title": "Mudança em interessado no seu pet " + newValue.nome,
//							"body": "Por favor, verificar interessados",
//						},
//						"data": {
//							"sound": "default",
//							"click_action" : "FLUTTER_NOTIFICATION_CLICK",
//							"screen" : "MYPETSPAGE",
//						}
//					}
//					return admin.messaging().sendToDevice (token, payload).then((response) => {
//						console.log('Enviada notificação');
//					}).catch((err) => {
//						console.log(err);})
//				}
//			}
//		})
//	})

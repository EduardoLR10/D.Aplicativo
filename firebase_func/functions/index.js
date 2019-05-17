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
			var newSizeInt = change.after.child(interessados).numChildren;
			var oldSizeInt = change.before.child(interessados).numChildren;


			if(!user.exists)
				return null;

			else{
				token = user.val().token;

				console.log(newSizeInt);

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
						var rem_id = 0;

						while (rem_id < newValue.interessados.length)
						{
							if(newValue.interessados[rem_id] == null && previousValue.interessados[rem_id] != null)
								break;

							rem_id ++;
						}

						var ref_inter = 'users/' + previousValue.interessados[rem_id].user_uid;

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

exports.interessadoTrigger = functions.database.ref('animals/{animalId}/interessados/{interessadoId}')
.onWrite((change,context) => {

	animalNome = admin.database().ref('animals/{animalId}').on('value',
		function(animal) { 
			var animalNome = animal.val().nome;
			var ref_dono = 'users/' + animal.val().dono;

			if (change.before.exists())
			{
				if (!(change.after.exists())) //removido
				{
					const previousValue = change.before.val();

					var ref_inter = 'users/' + previousValue.user_uid;

					admin.database().ref(ref_inter).on('value',
						function(interessado) {

							token = interessado.val().token;
							var payload = {
								"notification": {
									"title": "Pedido de adocao cancelado ",
									"body": "Não aceito seu pedido de adoção de " + animalNome,
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
				return null;
			} // se existia

			else
			{
				return null;
			}
	}) // animal
}) // onWrite
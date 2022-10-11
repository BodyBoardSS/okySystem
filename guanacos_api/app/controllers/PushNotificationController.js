const https = require('https')

module.exports = {
    sendNotification(token, data){
        const notification = JSON.stringify({
            'to':token,
            'data':{
                'click_action':'FLUTTER_NOTIFICATION_CLICK',
                'title': data.title,
                'body':data.body,
                'id_notification': data.id_notification
            },
            'notification':{
                'click_action':'FLUTTER_NOTIFICATION_CLICK',
                'title': data.title,
                'body':data.body,
                'id_notification': data.id_notification
            },
            'priority':'high',
            'ttl':'4500s'
        })

        const options = {
            hostname: 'fcm.googleapis.com',
            path: '/fcm/send',
            method:'POST',
            port:443,
            headers:{
                'Content-Type':'application/json',
                'Authorization':'key=AAAAeekJfK8:APA91bFbhoV3xK2I5iYVe3mJhFYKJpnIuDDFB3zoOJETaO_QoFvgTg9Da40vq77ulXfzfrKxo5RU9x0AoDKgX8iLAI_q14UPHVpnJGwZzp4ZE4ODoOFio12HRz7HJ5Erexvl-DiUs7Dl',

            }
        }

        const req = https.request(options, (res)=>{
            console.log('Status Code Firebase', res.statusCode)

            res.on('data', (d) => {
                process.stdout.write(d)
            })
        })

        req.on('error', (error) =>{
            console.log('Error de firebase messaging', error)
        })

        req.write(notification)
        req.end()
    }
}
const Discord = require('discord.js');
const client = new Discord.Client();

client.on('ready',()=>{
    console.log('Hypixel EZ logged in as ' + client.user.tag);
    client.user.setActivity("Against a Noob | Made by Timothy#9995"); 
});

const prefix = "!";
client.login("the bot key");

var messages = ["Wait... This isn't what I typed!", "Anyone else really like Rick Astley?", "Hey helper, how play game?", "Sometimes I sing soppy, love songs in the car.", "I like long walks on the beach and playing Hypixel", "Please go easy on me, this is my first game!", "You're a great person! Do you want to play some Hypixel games with me?", "In my free time I like to watch cat videos on Youtube", "When I saw the witch with the potion, I knew there was trouble brewing.", "If the Minecraft world is infinite, how is the sun spinning around it?", "Hello everyone! I am an innocent player who loves everything Hypixel.", "Plz give me doggo memes!", "I heard you like Minecraft, so I built a computer in Minecraft in your Minecraft so you can Minecraft while you Minecraft", "Why can't the Ender Dragon read a book? Because he always starts at the End.", "Maybe we can have a rematch?", "I sometimes try to say bad things then this happens :(", "Behold, the great and powerful, my magnificent and almighty nemisis!", "Doin a bamboozle fren.", "Your clicks per second are godly. :scream:", "What happens if I add chocolate milk to macaroni and cheese?", "Can you paint with all the colors of the wind", "Blue is greener than purple for sure", "I had something to say, then I forgot it.", "When nothing is right, go left.", "I need help, teach me how to play!", "Your personality shines brighter than the sun.", "You are very good at the game friend.", "I like pineapple on my pizza", "I like pasta, do you prefer nachos?", "I like Minecraft pvp but you are truly better than me!", "I have really enjoyed playing with you! <3", "ILY <3", "Pineapple doesn't go on pizza!", "Lets be friends instead of fighting okay?"];

//When any message is sent
client.on('message',message =>{
    //Convert it to all lower case
    var thisismsg = message.content;
    const str = thisismsg.toLowerCase();
    //If it contains the substring "ez"
    if (str.includes("ez")){
        //Delete the message
        message.delete();
        //Select a random message
        var funnytext = messages[Math.floor(Math.random() * messages.length)];
        //Create a webhook that looks like the user
        let user = client.users.cache.get(message.author.id);
        client.channels.cache.get(message.channel.id).createWebhook(user.username , { avatar: user.displayAvatarURL()}).then(async hook=>{
        const web = new Discord.WebhookClient(hook.id, hook.token);
        //Send the message
        web.send(funnytext)
        //Delete the webhoook
        await hook.delete()
        }
        )
    }
    return;
});
const express = require('express');
const http = require('http');
const mongoose = require('mongoose');
const Room = require('./models/room');

const app = express();
const port = process.env.PORT || 3000;
const server = http.createServer(app);
const io = require('socket.io')(server);


app.use(express.json());
app.get('/', (req, res) => {
    res.json("hello world!");
});

//socket.io connection

io.on('connection', (socket) => {
    console.log("socket connected");
    console.log(socket.id);
    socket.on("createRoom", async ({ nickname }) => {
        try {
            let room = new Room();
            let player = {
                socketId: socket.id,
                nickname: nickname,
                playerType: 'X',
            };
            room.players.push(player);
            room.turn = player;
            room = await room.save();
            // console.log(room);
            const roomId = room._id.toString();
            socket.join(roomId);
            io.to(roomId).emit('createRoomSuccess', room);
        } catch (error) {
            console.log(error);
        }
    });
    socket.on("joinRoom", async ({ nickname, roomId }) => {
        try {
            if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
                socket.emit("errorOccured", "Please enter a valid Room ID.");
                return;
            }
            let room = await Room.findById(roomId);
            if (room.isJoin) {
                let player = {
                    nickname: nickname,
                    socketId: socket.id,
                    playerType: "O"
                }
                socket.join(roomId);
                room.players.push(player);
                room.isJoin = false;
                room = await room.save();
                io.to(roomId).emit('joinRoomSuccess', room);
                io.to(roomId).emit('updatePlayers', room.players);
                io.to(roomId).emit('updateRoom', room);
            } else {
                socket.emit("errorOccured", "The Game is in progress, try again later.");

            }
        } catch (error) {
            console.log(error);
        }
    });
    socket.on('tap', async ({ index, roomId }) => {
        try {
            let room = await Room.findById(roomId);
            let choice = room.turn.playerType;
            if (room.turnIndex == 0) {
                room.turn = room.players[1];
                room.turnIndex = 1;
            }
            else {
                room.turn = room.players[0];
                room.turnIndex = 0;
            }
            room = await room.save();
            io.to(roomId).emit('tapped', {
                index,
                choice,
                room,
            });
        }
        catch (error) {
            console.log(error);
        }
    });
    socket.on('winner', async ({ winerSocketId, roomId }) => {
        try {
            let room = await Room.findById(roomId);
            room.players.forEach((playerData)=>{
                playerData.isReadyToPlay = false;
            })
            let player = room.players.find((playerData) =>
                playerData.socketId == winerSocketId
            );
            if (player.points === 0) {
                player.points = 1;
            } else {
                player.points++;
            }
            room.currentRound = room.currentRound + 1;
            room = await room.save();
            if (room.currentRound > room.maxRounds) {
                io.to(roomId).emit('endGame', player);
            } else {
                io.to(roomId).emit('pointIncrease', player);
            }

        } catch (error) {
            console.log(error);
        }
    });

    socket.on('ReadyToPlay', async ({isReady, playerSocketId, roomId}) => {
        try {
            let room = await Room.findById(roomId);
            let player = room.players.find((playerData) => playerData.socketId == playerSocketId);
            player.isReadyToPlay = true;
            room = await room.save();
            console.log(player);
            io.to(roomId).emit('playerReady', player);
        } catch (error) {
            console.log(error);
        }
    });
});

// mongodb connection
const DB = "mongodb+srv://yashbhagwani88:Yash-tictactoe-3135@cluster0.8yuqeax.mongodb.net/?retryWrites=true&w=majority"

mongoose.connect(DB).then(() => {
    console.log("connection successful");
}).catch((e) => {
    console.log(`Error connecting${e}`);
});


server.listen(port, () => {
    console.log(`Server listening on ${port}`);
});


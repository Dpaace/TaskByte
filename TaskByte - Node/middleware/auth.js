const jwt = require("jsonwebtoken")

const verifyUser = (req, res, next) => {
    if(!req.headers.authorization) {
        let err = new Error("Authorization token is missing")
        res.status(400)
        return next(err)
    }
    // console.log(req.headers.authorization)
    token = req.headers.authorization.split(' ')[1]
    console.log(token)
    jwt.verify(token, process.env.SECRET, (err, decoded) => {
        if(err) return next(err)
        req.user = decoded
        next()
    })
}

module.exports = {
    verifyUser
}
import express from 'express'

const app = express()
const PORT = 8080

app.get('/', (req, res, next) => {
  res.send({test: 'hello', 'status': 'success'})
})

app.listen(PORT, () => {
  console.log(`🚀starting server at https://localhost:${PORT}`)
})
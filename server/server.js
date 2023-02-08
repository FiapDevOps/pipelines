const express = require('express');
const promMid = require('express-prometheus-middleware');
const cors = require('cors');

const app = express();
const port = process.env.PORT || 5000;


// https://www.npmjs.com/package/express-prometheus-middleware
app.use(promMid({
  metricsPath: '/metrics',
  collectDefaultMetrics: true,
}));


app.use(cors());
app.use(express.json());

app.get('/', (req, res) => {
    res.json({ message: "Ok you got here, congrats! ... now go to /metrics to monitore your stufs" });
});

app.listen(port, () => {
  console.log('Sample app listening on port ' + port + '!');
  
});
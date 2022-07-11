const http = require('http')

// bind to all IPs, on port 8080
const hostname = '0.0.0.0';
const port = 8080
const version = "0.0.3";

const { networkInterfaces } = require('os')

// grot through networkInterfaces looking for IPv4 interfaces that are not
// marked as 'internal'.
const nets = networkInterfaces()
const ips = []
for (const name of Object.keys(nets)) {
    for(const net of nets[name]) {
        if (net.family === 4 || net.family === "IPv4" && !net.internal) {
            ips.push(net.address)
        }
    }
}

const server = http.createServer((req, res) => {
    res.statusCode = 200;
    res.setHeader ('Content-Type', 'text/plain')
    res.end(`${version}: Hello, World. My host IP(s) are: ${ips}`)
});

server.listen(port, hostname, () => {
    console.log(`${version}: Server (${ips}) listening on port http://${hostname}:${port}/\n`)
})

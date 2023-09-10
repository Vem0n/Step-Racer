exports.checkHealth =  async (req, res, next) => {
    try {
            console.log('Health Success')
            return res.status(200).json({message: "success"})
        
    } catch (e) {
        console.log(e);
        return res.status(500).json({message: "failed"})
    }
}
express = require 'express'
router = express.Router()

config = require 'config'
homeUrl = config.get 'developers.homeUrl'

#대메뉴 선택 조건문용
siteCategory = 'community'

router.get '/', (req, res) ->
  res.render 'index',  {
        title: res.__('커뮤니티'),
        homeUrl,
        siteCategory
  }

module.exports = router

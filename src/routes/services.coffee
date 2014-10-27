express = require 'express'
router = express.Router()

config = require 'config'
homeUrl = config.get 'developers.homeUrl'

#대메뉴 선택 조건문용
siteCategory = 'services'

router.get '/', (req, res) ->
  res.render 'services/index', {
        title: res.__('서비스'),
        homeUrl,
        siteCategory
  }

router.get '/detail', (req, res) ->
  res.render 'services/detail', { title: '상세' }

router.get '/doc', (req, res) ->
  res.render 'services/doc', { title: '문서' }

router.get '/doc-play', (req, res) ->
  res.render 'services/doc-play', { title: '문서-실행모드' }

module.exports = router

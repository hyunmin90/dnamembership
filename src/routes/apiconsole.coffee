express = require 'express'
router = express.Router()
daumauth = require '../lib/daumauth'
config = require 'config'
apibookClient = require '../lib/apibook-client'

homeUrl = config.get 'developers.homeUrl'

router.get '/', (req, res) ->
  # 로그인 체크
  prof = daumauth.checkLogin req, res
  return res.end() unless prof

  apibookClient.getAppsByUser prof['USERID'], (err, apps) ->
    return res.end() unless apps or apps.length > 0

    currentAppId = apps[0].id

    apibookClient.getAppById currentAppId, (err, currentApp) ->
      return res.end() unless currentApp?
      
      res.render 'console-info', {
        title: res.__('콘솔')
        prof
        homeUrl
        apps
        currentApp
      }

router.get '/:appId/info', (req, res) ->
  # 로그인 체크
  prof = daumauth.checkLogin req, res
  return res.end() unless prof

  currentAppId = req.params.appId

  apibookClient.getAppsByUser prof['USERID'], (err, apps) ->
    return res.end() unless apps or apps.length > 0
    apibookClient.getAppById currentAppId, (err, currentApp) ->
      return res.end() unless currentApp?

      currentApp.level = 'Silver';

      currentApp.users.forEach (user) ->
        if user.userId is prof['USERID']
          prof['PERMISSION'] = res.__('소유자')
          return

      currentApp.beholders.forEach (beholder) ->
        if beholder.userId is prof['USERID']
          prof['PERMISSION'] = res.__('개발자')
          return          

      res.render 'console-info', {
        title: res.__('개요')
        prof
        homeUrl
        apps
        currentApp
      }


router.get '/apikey', (req, res) ->
  res.render 'console-apikey', { title: 'API 키' }

router.get '/apilist', (req, res) ->
  res.render 'console-apilist', { title: 'API 항목' }

router.get '/stats', (req, res) ->
  res.render 'console-stats', { title: '통계' }

router.get '/team', (req, res) ->
  res.render 'console-team', { title: '팀 관리' }

module.exports = router

import jenkins.model.*
import hudson.security.*

def instance = Jenkins.getInstance()

println('>>> Creating a NEW Jenkins admin user...')

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount('newadmin', 'NewPassword123!')
instance.setSecurityRealm(hudsonRealm)

def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
instance.setAuthorizationStrategy(strategy)

instance.save()

println('>>> NEW ADMIN CREATED: username=newadmin / password=NewPassword123!')

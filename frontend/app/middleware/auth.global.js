export default defineNuxtRouteMiddleware((to,from)=>{
    const token = useCookie('token');
    const user = useCookie('user');
    if(!token.value){
        if(to.path!='/'){
            return navigateTo('/')
        }
        return
    }
    if(token.value && user.value){
        if(user.value.status=='suspend'){
            token.value = null;
            user.value = null;
            return navigateTo('/')
        }
        if(user.value.status=='newbie'){
            if(to.path!='/first-login'){
                return navigateTo('/first-login')
            }
            return
        }
        else{
            if(to.path=='/' || to.path == '/first-login'){
                return navigateTo('/'+user.value.role)
            }
        }
        if(to.path.startsWith('/admin') && user.value.role!=='admin'){
            return navigateTo('/'+user.value.role)
        }
        if(to.path.startsWith('/evaluator') && user.value.role!=='evaluator'){
            return navigateTo('/'+user.value.role)
        }
        if(to.path.startsWith('/evaluatee') && user.value.role!=='evaluatee'){
            return navigateTo('/'+user.value.role)
        }
    
    }else{
        token.value = null;
        user.value = null;
        if(to.path=='/'){return navigateTo('/')}
    }
})
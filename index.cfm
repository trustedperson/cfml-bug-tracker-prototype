	<cfif GetAuthUser() NEQ "">
		<cflocation addtoken="false" url="buglist.cfm">
	</cfif>

	<div class="heading">
		<p class="heading__text">Please login</p>
	</div>

		<form class="login-form" action="login_check.cfm" method="post" >
	        <span>
	            <input class="login-form__input" name="j_username" type="text" size="30" maxlength="30" placeholder="username here" autocomplete="off">
	        </span>
	        <br>
	        <span>
	            <input class="login-form__input" name="j_password" type="password" size="30" maxlength="30" placeholder="password please" autocomplete="off">
	        </span>
	        </div>
	        <br>
	        <button class="login-form__button" type="submit">Go!</button>  
		</form>

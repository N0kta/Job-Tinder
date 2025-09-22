import React, {useEffect} from 'react';
import {redirectToLogin} from "../../static/js/keycloak";

function SignUp() {
        useEffect(() => {
            redirectToLogin();
        }, [])
    return null;
}

export default SignUp;
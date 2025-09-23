import React, {useEffect} from 'react';
import {logout} from "../../static/js/keycloak";

function LogOut() {
        useEffect(() => {
            logout();
        }, [])
    return null;
}

export default LogOut;
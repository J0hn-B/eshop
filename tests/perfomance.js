import http from 'k6/http';
import { check, group, sleep } from 'k6';

export let options = {
    stages: [
        { duration: '1m', target: 100 }, // simulate ramp-up of traffic from 1 to 100 users over 1 minutes.
        { duration: '10m', target: 100 }, // stay at 100 users for 5 minutes
        { duration: '1m', target: 0 }, // ramp-down to 0 users
    ]

};

export default () => {
    let res = http.get(`http://localhost:45403/index.html`);
    check(res, { 'status was 200': r => r.status == 200 });
    check(res, { 'url is http://localhost:42659/index.html': r => r.url == 'http://localhost:42659/index.html' });

    //console.log('url is ' + String(res.url));

    let wel = http.get(`http://localhost:45403/category.html?tags=large`);
    check(wel, { 'status was 200': w => w.status == 200 });
    check(wel, { 'url is http://localhost:42659/category.html?tags=large': w => w.url == 'http://localhost:42659/category.html?tags=large' });
    //console.log('url is ' + String(wel.url));

    let edit = http.get(`http://localhost:45403/category.html`);
    check(edit, { 'status was 200': e => e.status == 200 });
    check(edit, { 'url is http://localhost:42659/category.html': w => w.url == 'http://localhost:42659/category.html' });
    //console.log('url is ' + String(edit.url));

    sleep(1);
};
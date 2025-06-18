import { ok, serverError } from "wix-http-functions";

const SCHEME = "https";
const SERVER = "www.wixapis.com";
const API_KEY = "IST.eyJraWQiOiJQb3pIX2FDMiIsImFsZyI6IlJTMjU2In0.eyJkYXRhIjoie1wiaWRcIjpcImE5ODI0YjFlLWE0YmMtNDZhMi1iNTNiLWRjOTBmNTRjMTQ5ZlwiLFwiaWRlbnRpdHlcIjp7XCJ0eXBlXCI6XCJhcHBsaWNhdGlvblwiLFwiaWRcIjpcImU5NzU2ZGE5LWNlMzktNGVhYy04MWZlLTg4ODA0OTM3NjlmMFwifSxcInRlbmFudFwiOntcInR5cGVcIjpcImFjY291bnRcIixcImlkXCI6XCIxMjQ2ZmU0ZC1jMmU0LTQwNmItOWNiOS1iMmZlZGJmNTJjM2RcIn19IiwiaWF0IjoxNzUwMTU1NDYyfQ.Di8jyRDfgoOFOzqZH_RKwX90ABinJMphSRiQGiBI17AJ7gQbYc_wV-xDbDjSpYPL5K2gau6snualvirRAvV_NCMY2MxEL3lSIrr0idcfWP92RSojdTG7VO3yZDSwAecwAsUcWmQfNH9hMhDHYEmDWFPIHlNSgH4KIjukIysV4IP-3aoVfO6FibXwXyzVdQNfbDJByh3H0qdbIXGwpL3Hq_zNB107VDlwH467oRqTQLofSATro7qEDjNwitlzUpTkS7KQfqBAHBaYvQ640NWs8kvvnGQYl5RA7hIfyAqfw9gUmuZyehtNyUbpv8b2MfpjZ_93v5EwQj5YaOmdxXtq-Q";
const AUTHORIZATION_TOKEN = "Bearer " + API_KEY;
const SITE_ID = "d03a309f-520f-4b7e-9162-dbb99244ceb7";

export async function get_users() {
    try {
        let membersResponse = await _get("members/v1/members");
        let members = membersResponse["members"];
        let contactsResponse = await _get("contacts/v4/contacts");
        let contacts = contactsResponse["contacts"];

        const contactsMap = {};
        for (const contact of contacts) {
            contactsMap[contact.id] = contact;
        }

        let users = [];

        users.push(...members.map((member) => {
            const contact = contactsMap[member.contactId];
            // TODO: validate that we can remove the inner or outer id
            return {
                dataCollectionId: "users",
                id: member.id,
                data: {
                    id: member.id,
                    contactId: contact.id,
                    firstName: contact.info.name.first,
                    lastName: contact.info.name.last,
                    middleName: contact.extendedFields.items["custom.middle-name"],
                    nickname:contact.extendedFields.items["custom.nickname"],
                    picture: contact.picture
                }
            };
        }));

        let body = { dataItems: users }
        return ok({ body: JSON.stringify(body) });
        // TODO: handle paging
    } catch (e) {
        console.error(e);
        return serverError({
            body: JSON.stringify({
                message: e.message || "Unknown error",
                stack: e.stack
            })
        });
    }
}

async function _get(path) {

    const url = buildUrl(path);

    try {
        const response = await fetch(url, {
            method: "get",
            headers: {
                "Authorization": AUTHORIZATION_TOKEN,
                "Content-Type": "application/json",
                "wix-site-id": SITE_ID
            }
        });

        return await response.json();
    } catch (e) {
        console.error("_get error: " + e);
    }
}

function buildUrl(path) {
    return SCHEME + "://" + SERVER + "/" + path;
}

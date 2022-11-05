const { Client } = require("@notionhq/client")

const updateInterval = 300000
const todosCountFilter = {
    "and": [
        {
            "property": "近期任務",
            "checkbox": {
                "equals": true
            }
        },
        {
            "property": "完成",
            "checkbox": {
                "equals": false
            }
        },
        {
            "property": "清單",
            "select": {
                "does_not_equal": "垃圾桶"
            }
        }
    ]

}

const loadTodosCount = async () => {
    const token = localStorage.getItem('flutter.t')
    if (!token) return;


    const client = new Client({
        auth: token.replaceAll("\"", "")
    })

    let count = 0
    const todosId = localStorage.getItem('flutter.Todosdl')
    count += await getCount(client, todosId, todosCountFilter)

    const unreadsId = localStorage.getItem('flutter.Unreadsdl')
    count += await getCount(client, unreadsId)

    setBadge(count)
};

const getCount = async (client, id, filter) => {
    if (id) {
        const response = await client.databases.query({
            database_id: id.replaceAll("\"", ""),
            filter: filter
        })
        return response.results.length;
    }
    return 0;
}

const setBadge = async count => {
    chrome.browserAction.setBadgeText({ text: `${count}` });
    chrome.browserAction.setBadgeBackgroundColor({color: '#D00218'})
};

loadTodosCount()
setInterval(() => loadTodosCount(), updateInterval);


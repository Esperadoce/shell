// pragma Singleton
// pragma ComponentBehavior: Bound

// import qs.config
// import Quickshell
// import Quickshell.Io
// import QtQuick

// Singleton {
//     id: root

//     // Reference to the AI configuration
//     property AiConfig config: AiConfig {}

//     // Expose config properties for convenience
//     property bool enabled: config.enabled
//     property string currentModel: config.model.model
//     property string apiUrl: config.model.apiUrl
//     property string apiKey: config.model.apiKeyrrrr
//     property string authHeader: config.model.authHeader
//     property var extraBodyProperties: config.model.extraBodyProperties

//     property bool isLoading: false
//     property var messages: messagesModel
//     property string lastError: ""

//     // Message model
//     property ListModel messagesModel: ListModel {}

//     // Store conversation history for context
//     property var conversationHistory: []

//     // Reset conversation
//     function clearConversation() {
//         messagesModel.clear()
//         conversationHistory = []
//         lastError = ""
//     }

//     // Send a message to the AI
//     function sendMessage(userMessage: string): void {
//         if (!enabled) {
//             lastError = "AI is disabled in config"
//             return
//         }

//         if (userMessage.trim() === "") {
//             return
//         }

//         // Add user message to model
//         messagesModel.append({
//             "role": "user",
//             "content": userMessage,
//             "timestamp": new Date().toISOString()
//         })

//         // Add to conversation history
//         conversationHistory.push({
//             "role": "user",
//             "content": userMessage
//         })

//         isLoading = true
//         lastError = ""

//         // Build the request body
//         var requestBody = {
//             "model": currentModel,
//             "messages": conversationHistory,
//             "stream": false
//         }

//         // Merge extra body properties if any
//         var extraProps = extraBodyProperties
//         if (extraProps && Object.keys(extraProps).length > 0) {
//             Object.assign(requestBody, extraProps)
//         }

//         httpRequest.body = JSON.stringify(requestBody)
//         httpRequest.headers = ({
//             "Content-Type": "application/json",
//             "Authorization": authHeader
//         })
//         httpRequest.url = apiUrl
//         httpRequest.call()
//     }

//     // HTTP request for AI API calls
//     HttpRequest {
//         id: httpRequest

//         property string body: ""
//         property var headers: ({})

//         method: HttpRequest.Post

//         onFinished: {
//             isLoading = false
//             var response = JSON.parse(responseBody)

//             if (response.error) {
//                 lastError = response.error.message || "Unknown API error"
//                 return
//             }

//             if (response.choices && response.choices.length > 0) {
//                 var assistantMessage = response.choices[0].message.content

//                 // Add assistant message to model
//                 messagesModel.append({
//                     "role": "assistant",
//                     "content": assistantMessage,
//                     "timestamp": new Date().toISOString()
//                 })

//                 // Add to conversation history
//                 conversationHistory.push({
//                     "role": "assistant",
//                     "content": assistantMessage
//                 })
//             }
//         }

//         onError: {
//             isLoading = false
//             lastError = "Network error: " + errorMessage
//         }
//     }
// }
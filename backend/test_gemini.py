from google import genai

client = genai.Client(
    api_key="AIzaSyAtL6TbZtG_yRkWVA7K2AdkIuHBZhpWxbY"
)

response = client.models.generate_content(
    model="gemini-1.5-flash",
    contents="Say hello in one short sentence."
)

print(response.text)

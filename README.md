# Mila Shopping App

🛒 **Shop Buddy Mila** - Your AI-powered shopping assistant for the Netherlands

## Overview

Mila is an innovative shopping app that follows a unique "same features, different experience" model:
- **Free users**: Get all features with full manual control
- **Premium users**: Get the same features but with Mila AI assistant doing the work for you (€4.95/month after 30-day trial)

## Features

### Core Features (Available to All)
- 📝 **Shopping Lists** - Create and manage unlimited shopping lists
- 🍳 **Recipe Management** - 500+ recipes with meal planning
- 🧾 **Receipt Scanning** - Track expenses and savings
- 📦 **Inventory Management** - Track pantry items and expiration dates
- 🏪 **Store Features** - Find nearby stores, check hours, optimize routes

### Premium Experience with Mila AI
- 🎙️ Voice-first interface: "Hey Mila, create my weekly shopping list"
- 🤖 Proactive suggestions based on your habits
- 🎉 Celebrates your savings achievements
- 🗣️ Natural language interactions in Dutch
- ⚡ Automatic list generation and management

## Tech Stack

- **Frontend**: React Native + Expo (TypeScript)
- **Backend**: Supabase (PostgreSQL)
- **AI**: OpenAI API (for Mila)
- **State Management**: Redux Toolkit + RTK Query
- **Authentication**: Supabase Auth + Google OAuth

## Database Schema

The app uses a comprehensive database schema with:
- 22+ tables for all features
- Row Level Security for data protection
- Full-text search in Dutch
- Geospatial queries for store locations
- Automated trial system (30 days)

## Getting Started

1. Clone the repository
2. Copy `.env.example` to `.env` and fill in your credentials
3. Install dependencies: `npm install`
4. Start the development server: `npm start`

## Development Status

🚧 **Currently in active development**

### Completed:
- ✅ Project setup and structure
- ✅ Complete database schema
- ✅ TypeScript configuration
- ✅ Supabase integration

### Next Steps:
- 🔄 Authentication flow with trial system
- 🔄 Home screen (adaptive UI for free/premium)
- 🔄 Shopping lists functionality
- 🔄 Mila AI integration

## License

This project is private and proprietary.

---

Built with ❤️ for Dutch shoppers
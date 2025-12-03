---
description: Deploy to Render using Blueprint
---

# Deploy to Render

This workflow guides you through deploying the application to Render using the Blueprint configuration.

## Prerequisites
- GitHub repository is up to date with latest changes
- Render account created at https://render.com

## Steps

1. **Ensure all changes are committed and pushed**
   ```bash
   git status
   git add .
   git commit -m "chore: prepare for Render deployment"
   git push origin main
   ```

2. **Go to Render Dashboard**
   - Navigate to https://dashboard.render.com/
   - Click "New" → "Blueprint"

3. **Connect GitHub Repository**
   - Select your GitHub account
   - Choose the repository: `codewithriad/lernen-frontend`
   - Click "Connect"

4. **Configure Blueprint**
   - Render will automatically detect `render.yaml`
   - Review the service configuration
   - Fill in required environment variables:
     - `APP_URL`: Your Render app URL (e.g., `https://your-app.onrender.com`)
     - `DB_HOST`: Your database host
     - `DB_DATABASE`: Your database name
     - `DB_USERNAME`: Your database username
     - `DB_PASSWORD`: Your database password

5. **Apply Blueprint**
   - Click "Apply" to start deployment
   - Wait for the build to complete (this may take 5-10 minutes)

6. **Verify Deployment**
   - Once deployed, click on the service URL
   - Check that the application loads correctly

## Important Notes

- **Free Tier**: Render's free tier spins down after 15 minutes of inactivity. First request after spin-down may take 30-60 seconds.
- **Database**: You can create a free PostgreSQL database on Render or connect to an external MySQL database.
- **Environment Variables**: You can update environment variables anytime in the Render dashboard under "Environment" tab.
- **Logs**: View real-time logs in the Render dashboard to debug any issues.

## Troubleshooting

If deployment fails:
1. Check the build logs in Render dashboard
2. Verify all environment variables are set correctly
3. Ensure `render.yaml` is in the root of your repository
4. Check that `Dockerfile` is properly configured

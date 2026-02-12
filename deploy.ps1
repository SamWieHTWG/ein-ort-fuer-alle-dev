param(
    [string]$CommitMessage
)

# 1. Set BASE_URL for GitHub Pages
$configPath = "src/lib/config.ts"
Write-Host "Setting BASE_URL to GitHub Pages..." -ForegroundColor Cyan
$configContent = @"
/**
 * Application configuration
 * Change BASE_URL here to switch between production and test environments
 */

// For production (statiqs.eu):
// export const BASE_URL = 'https://www.statiqs.eu';

// For GitHub Pages testing:
export const BASE_URL = 'https://ein-ort-fuer-alle.github.io/';

// For local testing with base path:
// export const BASE_URL = '';
"@
Set-Content -Path $configPath -Value $configContent
Write-Host "BASE_URL set to GitHub Pages" -ForegroundColor Green

# 2. Build the project
Write-Host "Building project..." -ForegroundColor Cyan
yarn build
if ($LASTEXITCODE -ne 0) {
    Write-Error "Build failed!"
    exit $LASTEXITCODE
}

# 3. Prepare Target Directory
$targetDir = "..\ein-ort-fuer-alle.github.io"
Write-Host "Cleaning target directory: $targetDir" -ForegroundColor Cyan

if (Test-Path $targetDir) {
    Push-Location $targetDir
    # Remove all directories except .git
    Get-ChildItem -Directory | Where-Object { $_.Name -ne ".git" } | Remove-Item -Recurse -Force
    # Remove all files in the root except CNAME
    Get-ChildItem -File | Where-Object { $_.Name -ne "CNAME" } | Remove-Item -Force
    Pop-Location
} else {
    Write-Error "Target directory $targetDir does not exist!"
    exit 1
}

# 4. Copy Build Files
Write-Host "Copying build files..." -ForegroundColor Cyan
xcopy /E /I /Y build $targetDir

# 4b. Add .nojekyll to prevent GitHub Pages from ignoring _app/ directory
Write-Host "Adding .nojekyll file..." -ForegroundColor Cyan
New-Item -Path "$targetDir\.nojekyll" -ItemType File -Force | Out-Null

# 5. Commit changes in current repo
Write-Host "Committing changes in current repo..." -ForegroundColor Cyan
$currentRepoMsg = if ($CommitMessage) { $CommitMessage } else { "Site update $(Get-Date -Format 'yyyy-MM-dd HH:mm')" }
git add .
git commit -m $currentRepoMsg
git push

# 6. Git Commit and Push to target repo
Write-Host "Committing and pushing changes to target repo..." -ForegroundColor Cyan
$targetRepoMsg = if ($CommitMessage) { $CommitMessage } else { "Deploy update $(Get-Date -Format 'yyyy-MM-dd HH:mm')" }
Push-Location $targetDir
git add .
git commit -m $targetRepoMsg
git push
Pop-Location

Write-Host "Deployment complete!" -ForegroundColor Green
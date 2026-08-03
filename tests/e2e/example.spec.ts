import { test, expect } from '@playwright/test';

test('basic e2e smoke test', async ({ page }) => {
  await page.goto('/');
  // Basic smoke check: page loads
  await expect(page).toBeTruthy();
});

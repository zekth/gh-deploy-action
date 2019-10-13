# gh-deploy

Completely inspired by https://github.com/maxheld83/ghpages

## Usage

Env variables:
- **dir** : Directory to deploy. Default is `./`
- **gh_token** : Personnal access token. [Create one](https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line)
- **fqdn** : Creating a CNAME file in the target with the input. Also does domain name regex validation
- **target_branch** : Target branmch where to deploy. Default : `gh-pages`

```yaml
- name: GitHub Pages Deploy
    if: github.ref == 'refs/heads/master'
    uses: zekth/gh-deploy-action@1.0.0
    with:
        dir: dist/
        gh_token: ${{ secrets.GH_TOKEN }}
        fqdn: foo.bar.com
        target_branch: staging
```
